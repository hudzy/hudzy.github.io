---
layout: post
title: "阿里云开源了两个 AIOps Skills 项目，顺手翻了下源码"
date: 2026-05-25
tags: [笔记, 工作, AI, AIOps, 阿里云]
---

周末刷 GitHub，看到阿里云连着开源了两个项目：

- [alibabacloud-aiops-skills](https://github.com/aliyun/alibabacloud-aiops-skills)：阿里云官方 Agent Skills 大集合，覆盖了很多产品线。
- [alibabacloud-ecs-troubleshoot-skills](https://github.com/aliyun/alibabacloud-ecs-troubleshoot-skills)：专门给 ECS Linux 实例做问题排查的 Skill。

授权信息略有点乱：`ecs-troubleshoot` 仓库明确是 Apache-2.0；`aiops-skills` 的 README 里 License 段写 Apache-2.0，Legal 段又提到 MIT，而且根目录暂时没看到 LICENSE 文件。先不纠结这个细节。我把两个仓库 clone 下来翻了大半天，觉得这事比表面上有意思，不是又一个 "AI for DevOps" 的 PPT 概念，更像是云厂商把 SRE 那本看不见的内部 runbook 系统性地摊开了。下面把看到的东西记一下。

## 先聊点背景：AIOps 到底在解决什么

AIOps 这个词最早是 Gartner 在 2016 年提的，原意是 "Algorithmic IT Operations"。听着挺玄，其实拆开就两件事：

1. **指标 / 日志 / 事件的智能化**：异常检测、根因定位、容量预测，这一波在 2018 年前后已经基本被各大厂跑通了。
2. **运维流程的自动化**：从值班 SOP 到工单处理，能用代码替代人的部分尽量替代。

LLM 出来之前，第二件事进展一直磕磕绊绊。原因也不复杂：流程类的东西很难 schema 化，每个公司、每条业务线的 SOP 都有些只可意会的细节，写死成脚本要么死板要么爆炸。LLM 出来之后情况就反过来了，你只要把那些写在 Confluence、Wiki 上的中文 / 英文 runbook 喂给模型，模型就能照着做，至少表面上能做。

但很快又遇到新问题：**LLM 一旦开始 "自己想"，就开始胡说**。让它执行十步排查流程，前八步它会改成自己觉得更优雅的写法；指标读出来是错的，它能给你脑补一个根因；最后给客户一份看起来很专业但根本没法复现的诊断报告。所以这一年大家逐渐回到一个共识：**Agent 要靠规则收敛，不能放飞自我**。

Anthropic 去年 10 月推出 [Agent Skills](https://agentskills.io/) 时，走的就是这个思路；到了年底，又把它开放成一个跨平台标准。一个 Skill 本质上是一个带 frontmatter 的 Markdown 文件，里面写清楚什么时候触发、要按什么顺序做、可以调哪些工具、不允许做什么。模型在合适的时机加载这份 Skill，按里面写的步骤跑。说白了就是把 prompt engineering 这件事做成一种工程化的、可复用的资产。

阿里云这两个仓库就是冲着 Agent Skills 这个标准去的。它们解决的是同一个问题：**把云上运维的 know-how 拆成 LLM 能可靠执行的脚本**。但侧重点完全不同。

## 插一句：Skills 是什么，Agent Harness 又在哪一层

在继续往下扒源码之前，得把这两个词捋清楚，不然后面看 SKILL.md 会有点云里雾里。

### Skill 的物理结构

一个 Skill 就是一个目录，长这样：

```
my-skill/
├── SKILL.md              # 主入口，必有
├── references/           # 可选：被主入口按需引用的子文档
│   ├── workflow.md
│   └── cheatsheet.md
└── scripts/              # 可选：可执行脚本
    └── run.py
```

`SKILL.md` 顶部是一段 YAML frontmatter：

```yaml
---
name: alibabacloud-ecs-diagnose
description: |
  Comprehensive Alibaba Cloud ECS instance diagnostics skill.
  Use when users report server connectivity issues, SSH timeout,
  instance lag, website unavailability, disk full, CPU/memory alerts...
  Triggers: "ECS", "instance", "SSH", "timeout", "disk full", ...
---
```

整套设计里最关键的一点是：**`description` 字段是给模型看的"什么时候轮到我上场"的广告语**。在 Anthropic 的实现里，SKILL.md 的正文不会一直挂在 context 里，常驻的主要是这段 description，可能就几十个 token。等模型判断当前对话跟这段描述匹配，才会主动把 SKILL.md 正文加载进来。如果 SKILL.md 正文里又引用了 `references/cheatsheet.md`，那也是要用的时候才读。

Anthropic 把这套机制叫 **progressive disclosure**，渐进式披露。

### 为什么这个细节重要

写过 LLM 应用的人都知道，context 窗口里塞什么、不塞什么，决定了系统的成本和质量上限。传统工具调用更偏向于把可调用的 API、参数和返回值暴露给模型。MCP 也是这个方向，只是把工具发现、工具调用和资源访问标准化了。不同 Harness 会有不同的索引和筛选策略，不一定真的把所有工具描述都硬塞进 system prompt，但本质上还是在回答一个问题：**模型现在能调用哪些动词？**

Skills 回答的是另一个问题：**这些动词应该怎么组合成一套流程？** 它适合放流程性 know-how，比如先查哪个指标、再确认哪个边界、什么情况下必须问用户、什么命令不能跑。MCP 提供工具，Skills 描述使用工具的打法。阿里云这两个仓库里很多 SKILL.md 最终都会落到 `aliyun` CLI 上调 API，CLI 是动词，SKILL.md 是剧本。

### Agent Harness 在哪一层

Skill 是规范，**Agent Harness 是把这套规范跑起来的运行时**。具体说，Harness 是那一段经典的"model + tools + memory"循环代码，负责：

1. 启动时扫描 `~/.agents/skills/` 等约定目录，把每个 Skill 的 description 注入 system prompt 或工具索引。
2. 模型在某一轮决定 "我要用 X Skill"，Harness 负责把 `SKILL.md` 正文读出来、塞进 context。
3. Skill 里引用了 `references/foo.md`，Harness 同样按需读取。
4. Skill 里给了 shell 命令、CLI 调用，Harness 负责执行、把结果回灌给模型。
5. 出错、超时、需要人工确认的位置，Harness 决定怎么处理。

市面上现在的 Harness 各有各的实现：Claude Code、Cursor、Cline、Aider、Codex CLI，以及一大堆基于厂商 API 自己撸的内部 Agent。它们读取 Skills 的细节都不太一样，权限模型、shell 沙箱、文件加载策略也会影响最终效果。但只要遵守 Agent Skills 这个事实标准，**同一份 Skill 至少有机会跨 Harness 复用**。这是这套规范存在的最大意义。

阿里云这两个仓库的 README 里推的 [skills.sh](https://skills.sh) 就是给这套生态做包管理用的：

```bash
npx skills add aliyun/alibabacloud-aiops-skills
```

干的事有点像 npm：从 GitHub 拉指定的 Skill 包，按版本号锁定，放到 Harness 能读到的位置。这一步如果跑通了，Skills 生态会有点像当年的 npm 之于 Node、cargo 之于 Rust，别人写好的"经验"可以被你的 Agent 直接 `add` 进来。

所以阿里云这两个仓库发的不是一个 Agent，而是一堆 Agent 可以加载的"插件"。Harness 当然重要，但流程知识被抽成了独立文件，不再绑死在某个具体 Agent 里。

## 仓库一：alibabacloud-aiops-skills

这个仓库基本上是阿里云全产品线 Skills 的总目录。我数了下，单是 `SKILL.md` 文件就有 **121 个**，按产品域分类：

```
skills/
├── aiml/              # AgentBay、OpenSearch、Avatar
├── analyticscomputing/# MaxCompute、Flink、Hologres、EMR、Elasticsearch、Milvus...
├── computing/         # ECS、EHPC、Alinux
├── database/          # RDS、PolarDB、ADB、MongoDB、ClickHouse、Lindorm、DTS...
├── developertools/
├── doweb/             # 域名、网站、备案
├── entcmc/            # 企业管理控制台
├── mediaservices/     # ICE、Live、MTS
├── middleware/        # API Gateway、CMS、PTS、StarOps
├── migrationom/       # 运维迁移、OOS、RAM
├── netcdn/            # DCDN、网络分析、SmartAG
├── others/
├── security/          # 云防火墙、DDoS、KMS、云安全中心、WAF
├── solutions/
└── storage/           # 块存储、HBR、OSS、表格存储、PDS、SLS
```

随便抽几个看：

- `alibabacloud-ecs-diagnose`：ECS 实例诊断，从云控制台层到 GuestOS 层的两级排查。
- `alibabacloud-rds-copilot`：通过 `aliyun rdsai chat-messages` 把官方 RDS Copilot 暴露给本地 Agent。
- `alibabacloud-polardb-ai-assistant`：PolarDB 智能运维，慢 SQL、主备切换、参数调优。
- `alibabacloud-oss-manage-metaquery`：OSS 上的语义检索，以文搜图、以文搜视频那一套。
- `alibabacloud-odps-cost-analysis`：MaxCompute 账单分析，限定只能用 10 个固定的 CLI 命令。
- `alibabacloud-sas-alert-handler`：云安全中心告警查询和处置。

挑一个我比较熟的看下里面长什么样。`alibabacloud-ecs-diagnose/SKILL.md` 的开头：

```yaml
---
name: alibabacloud-ecs-diagnose
description: |
  Comprehensive Alibaba Cloud ECS instance diagnostics skill...
  Triggers: "ECS", "instance", "server", "cannot connect", "SSH", ...
---
```

注意 `Triggers` 这段，这就是给 LLM 看的关键字匹配。用户聊 "我的 ECS 连不上" 的时候，模型自动会想到加载这个 Skill。

往下翻是几条 **[MUST]** 标记的硬要求，例如：

- 跑任何 CLI 命令之前先 `aliyun configure ai-mode enable`，结束时 `disable`。这是阿里云这边给 AI Agent 调用 CLI 打的特殊标记，方便后端按 Agent 流量做限流、计费、审计。
- 每个 CLI 调用必须带 `--user-agent AlibabaCloud-Agent-Skills/<skill-name>`，同样是为了埋点和归因。
- **绝对不允许** 读出、回显或打印 AK/SK，连 `echo $ALIBABA_CLOUD_ACCESS_KEY_ID` 都明确禁止。
- **绝对不允许** 让用户在对话里直接输 AK/SK，得让用户在自己终端里 `aliyun configure` 配好再回来。

这些约束写得很工程化，看得出是踩过坑的。上一代很多 "AI 运维助手" 翻车，都是栽在凭证泄露和无审计调用上。

下面是 `Scenario-Based Routing`：

```
| 问题场景          | 触发关键词                       | 排查路径                                |
|------------------|--------------------------------|----------------------------------------|
| 远程连接失败       | SSH timeout、RDP failure、...    | 读 remote-connection-diagnose-design.md |
| 性能问题          | slow、high CPU、unresponsive    | 读 generic-diagnostics-workflow.md     |
| 磁盘问题          | disk full、cannot write         | 读 generic-diagnostics-workflow.md     |
| 实例状态异常       | stopped、locked、system event   | 读 generic-diagnostics-workflow.md     |
```

这块本质上是个**路由表**：用关键字判断把用户的口语问题归类到一份具体的排查文档，然后按文档执行。说白了，就是把"老员工脑子里那张诊断决策树"显式地写出来。

## 仓库二：alibabacloud-ecs-troubleshoot-skills

这个仓库只有一个 Skill：`alibabacloud-ecs-linux-troubleshooting`，但内容深得离谱。

```
skills/alibabacloud-ecs-linux-troubleshooting/
├── SKILL.md                    # 主入口，定义排查 6 阶段流程
└── references/                 # 顶层 29 个引用文档，算上 utils 一共 46 个 Markdown
    ├── symptom-to-domain.md    # 自然语言 → 现象域 路由
    ├── phenomenon-domain.md    # 现象域权威枚举表
    ├── aliyun-cli-cheatsheet.md# CLI 子命令白名单
    ├── cpu-high.md             # CPU 高的完整排查 SOP
    ├── memory-oom.md           # OOM
    ├── disk-iops-high.md
    ├── network-packet-loss.md
    ├── ssh-login-failed.md
    ├── system-hang.md
    ├── system-crash.md
    ├── userdata-failed.md
    ├── ...
    └── utils/                  # 各 GuestOS 组件的细粒度排查文档
```

它把整个排查流程严格切成 6 个阶段，**必须按序执行**：

1. **澄清异常**：调 `aliyun.ecs.DescribeInstances` 抓实例状态，再向用户问范围（单实例还是多实例）、通道（VNC/SSH/云助手哪些可用）、网络方向、报错原文。
2. **归类现象域**：打开 `symptom-to-domain.md`，把用户的口语描述收敛成一个明确的 "现象域"，例如 `GuestOS.CPUUtilizationTooMuch`、`GuestOS.NetworkPacketDrop`。**必须让用户确认归类对不对**，错了就给 TOP 3 备选，再不对就建议提工单。
3. **确认是否属于 GuestOS 问题**：优先用 aliyun CLI 自己查清楚，**不允许在没尝试用 CLI 取数据的情况下直接问用户**。
4. **诊断工具快速排查**：调用 `aliyun.ecs.CreateDiagnosticReport` 跑预定义的诊断集合。
5. **GuestOS 内部排查**：通过 `aliyun.ecs.RunCommand` 远程执行命令采集数据，**一次性把这个现象域所有需要的数据都收完**，少跑几次 RunCommand。
6. **总结建议**：按模板生成结构化诊断报告。**不允许做任何修复操作**，只给结论和建议。

里面有几个细节我觉得特别值得抄作业的：

**第一，命令白名单**。文档里写得很清楚：

> 除了 `references/utils/guestos-pe-prep.md` 中的步骤外，其他步骤只能使用 `references/aliyun-cli-cheatsheet.md` 里列出的子命令，**不得调用未列出的子命令**。

这是给 LLM 戴了笼头。模型有时候会突发奇想用一个看着合理但其实不存在的 CLI 命令，或者用一个权限过大的命令。直接给白名单，简单粗暴有效。

**第二，每个现象域都有一份独立的 SOP**。看一下 `cpu-high.md` 的完整内容（一共就这点）：

```markdown
# CPU 使用率异常升高

## 确定是否属于 GuestOS 问题
1. 通过 aliyun.ecs.DescribeInstances 获取实例规格，
   通过 aliyun.ecs.DescribeInstanceTypes 判断是否共享型规格。
   - 是则无需排查（共享型不承诺性能 SLA）。
   - 否：继续。

## GuestOS 内问题排查流程
### 相关组件
- CPU 压力 / 进程调度器 / 业务进程 / perf 工具 / 硬中断 / 软中断

### 问题定位
1. 用云监控对一下异常时间是不是业务高峰。
2. 运行 `top -b -n 1`，看第三行 %Cpu 哪项高：
   - user 高：`perf top -p <pid>` 定位。
   - system 高：`perf record -g && perf report` 定位内核热点。
   - hardirq 高：`cat /proc/interrupts`。
   - softirq 高：`cat /proc/softirqs`。
   - wait 高：`ps aux | awk '$8 ~ /D/'`、`strace -p <pid>`、
            `cat /proc/<pid>/stack`。
3. 利用率不高但 Tasks 大量 running，可能是频繁 execve/fork，
   `pidstat 1 5` 观测。
```

我看到这段的时候特别有感触，这就是一个老 SRE 排查 CPU 高的肌肉记忆。以前这些东西都散落在每个老员工脑子里、Confluence 的某个角落、值班群里的某条聊天记录里。现在阿里云把它写成了机器能读懂的格式。

**第三，对客户的强制确认**。流程图里有一堆 `要求用户确认` 的节点。比如归类完现象域要让用户确认对不对，要执行诊断报告之前要问用户同不同意，等等。这跟前面那篇 [Why I'm Betting Against AI Agents in 2025]({% post_url 2025-07-27-Why I’m Betting Against AI Agents in 2025 (Despite Building Them) %}) 里说的 "human-in-the-loop at key points" 完全是同一个套路。**链路越长，越要插人审的卡点**。

## 两个仓库怎么配合用

两个仓库的关系大概是这样：

- **alibabacloud-aiops-skills** = 横向铺面，按产品分类，强调 "这个产品能干哪些事"。
- **alibabacloud-ecs-troubleshoot-skills** = 纵向打深，单点切入 ECS Linux 异常排查，强调 "这个问题怎么一步步定位"。

实际用的时候，对一个公司的运维场景，可能是：日常的资源查询、配置变更、监控查看走 `aiops-skills` 里对应产品的 Skill；线上真的出事故了，开排查会走 `ecs-troubleshoot-skills` 这种深度 SOP。

## 怎么跑起来

两个仓库的安装方式基本一样，都是基于 [skills.sh](https://skills.sh) 这个 Agent Skills 的包管理工具。注意它**只是负责把 Skill 文件放到正确位置**，真正执行 Skill 还得有个能读 Agent Skills 规范的 Harness，比如 Claude Code、Cursor，或者自己撸的 Agent；前提是它支持这套规范，能找到安装后的 Skill 文件。

先装 aliyun CLI 并配好凭证：

```bash
# macOS
brew install aliyun-cli

# Linux / 通用
/bin/bash -c "$(curl -fsSL https://aliyuncli.alicdn.com/install.sh)"

# 配置（也可以用环境变量 / EcsRamRole）
aliyun configure --profile default
```

然后选其中一种装 Skill。批量装一整个仓库：

```bash
npx skills add aliyun/alibabacloud-aiops-skills
npx skills add aliyun/alibabacloud-ecs-troubleshoot-skills -g
```

只装单个 Skill：

```bash
npx skills add aliyun/alibabacloud-aiops-skills \
  --skill alibabacloud-ecs-diagnose
```

或者就 git clone 下来手动放到 Agent 目录：

```bash
git clone https://github.com/aliyun/alibabacloud-ecs-troubleshoot-skills.git
mkdir -p ~/.agents/skills
cp -r alibabacloud-ecs-troubleshoot-skills/skills/* ~/.agents/skills/
```

凭证这块官方文档里有个挺重要的提醒：

- **AK/SK 认证** 和 **CLI profile 里存 AK 的方式** 只建议本地个人测试用，明文 AK/SK 容易泄。
- 上了云的服务，强烈推荐 **EcsRamRole** 凭证，让实例自己拿临时 STS Token。

这条建议我觉得值得划重点。我见过太多团队图省事，把 AK/SK 直接塞进环境变量然后扔进 Docker 镜像，再一个不小心 push 到了公网仓库。EcsRamRole 这种 instance metadata 派发临时凭证的方式，几乎是云上唯一能避免人为失误的姿势。

## 一些个人观感

我觉得最值得关注的，不是 Skills 这个格式本身，而是云厂商的 know-how 开始以可执行格式开源了。

过去十几年，每家云厂商的工单系统里都积累了海量 SOP。客户提一个 "SSH 连不上"，工程师按一套内部流程跑下来，最后给一份诊断回复。这套流程对每家云的客户都很有价值，但客户基本看不到，它锁在工单 SaaS 里。

阿里云这次把这部分东西按 Agent Skills 标准开源了，意味着：

1. 你自己跑的 Agent 也能拿到差不多质量的排查能力，不再只能通过提工单获得。
2. 多云场景下，你可以把这套 Skill 当模板，照着写一份 AWS、Azure 版本。结构都给你了，照葫芦画瓢就行。
3. 内部团队也可以用同样的格式沉淀自己的 runbook。一个 `SKILL.md` 配一个 `references/` 文件夹，比 Confluence 上那种从来没人维护的 wiki 强一万倍。

当然这只是个开始。可以预见的几个问题：

- **121 个 Skill 的维护负担会非常重**。每个产品都在迭代 API，每个 Skill 里的命令都得跟着变。这件事考验阿里云内部的协作机制。
- **Triggers 关键字会越来越冲突**。121 个 Skill 都在抢路由，模型选错 Skill 的概率会随着规模增加。
- **Harness 兼容性短期内不会真的统一**。Agent Skills 的规范虽然定义了 SKILL.md 格式，但各家 Harness 对 description 的注入位置、references 的加载策略、shell 调用的沙箱策略各有差异。阿里云的 Skill 在 Claude Code 里跑出来的样子，跟在某个自研 Agent 里跑出来很可能不是一回事。生态还得磨。
- **执行结果的回归测试**。每个 Skill 都标着 "已经过精心测试和验证"，但具体怎么测、出了 bug 怎么发现，这块目前还是黑盒。

这两个仓库放到一起看，我觉得方向是对的：**不要让 LLM 自己想运维流程，而是把流程喂给它**。这是过去两年我们交了一堆学费才得到的共识，能看到一线大厂用真东西验证这个方向，挺好。

值得 star、fork 下来翻翻，对自己写内部 Skill 也是个不错的参考。
