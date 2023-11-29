---
layout: post
title: "全方位对比 Postgres 和 MySQL (2023 版)"
date: 2023-07-17
tags: [笔记, 工作]
---

随着 Postgres 的发展势头愈发强劲，在 Postgres 和 MySQL 之间做选择变得更难了。

如果看安装数量，MySQL 可能仍是全球最大的开源数据库。

Postgres 则自诩为全球最先进的开源关系型数据库。

因为需要与各种数据库及其衍生产品集成，Bytebase 和各种数据库密切合作，而托管 MySQL 和 Postgres 最大的云服务之一 Google Cloud SQL (https://cloud.google.com/sql) 也是 Bytebase 创始人的杰作之一。

本文中，我们对 Postgres 和 MySQL 在以下几个维度进行了比较：

-   许可证 License
    
-   性能 Performance
    
-   功能 Features
    
-   可扩展性 Extensibility
    
-   易用性 Usability
    
-   连接模型 Connection Model
    
-   生态 Ecosystem
    
-   可运维性 Operability
    

除非另有说明，下文基于最新的主要版本 Postgres 15 和 MySQL 8.0 (使用 InnoDB)。在文章中，我们使用 **Postgres** 而不是 **PostgreSQL** ([可以说是搬起石头砸自己的脚](https://mp.weixin.qq.com/s?__biz=MzkzMjI2MDY5OQ==&mid=2247491654&idx=1&sn=e4107bfe150fa223ad50e1a9dd3c7f3a&scene=21#wechat_redirect))，尽管 PostgreSQL 才是官方名称，但被认为是一个错误的决定 (https://www.craigkerstiens.com/2018/10/30/postgres-biggest-mistake/)。

## **许可证 License**

-   MySQL 社区版采用 GPL 许可证。
    
-   Postgres 发布在 PostgreSQL 许可下，是一种类似于 BSD 或 MIT 的自由开源许可。
    

即便 MySQL 采用了 GPL，仍有人担心 MySQL 归 Oracle 所有，这也是为什么 MariaDB 从 MySQL 分叉出来。

## **性能 Performance**

对于大多数工作负载来说，Postgres 和 MySQL 的性能相当，最多只有 30% 的差异。无论选择哪个数据库，如果查询缺少索引，则可能导致 x10 ~ x1000 的降级。

话虽如此，在极端的写入密集型工作负载方面，MySQL 确实比 Postgres 更具优势。可以参考下文了解更多：

-   为什么 Uber 从 Postgres 迁移到 MySQL: https://www.uber.com/en-SG/blog/postgres-to-mysql-migration/
    
-   我们最讨厌的 PostgreSQL 部分: https://ottertune.com/blog/the-part-of-postgresql-we-hate-the-most/
    

除非你的业务达到了 Uber 的规模，否则纯粹的数据库性能不是决定因素。像 Instagram, Notion 这样的公司也能够在超大规模下使用 Postgres。

  

## **功能 Features**

### **对象层次结构**

MySQL 采用了 4 级结构：

1.  实例
    
2.  数据库
    
3.  表
    
4.  列
    

Postgres 采用了 5 级结构：

1.  实例（也称为集群）
    
2.  数据库
    
3.  模式 Schema
    
4.  表
    
5.  列
    

### **ACID 事务**

两个数据库都支持 ACID 事务，Postgres 提供更强大的事务支持。


### **安全性**

Postgres 和 MySQL 都支持 RBAC。

Postgres 支持开箱即用的附加行级安全 (RLS)，而 MySQL 需要创建额外的视图来模拟此行为。

### **查询优化器**

Postgres 的查询优化器更优秀，详情参考此吐槽：https://news.ycombinator.com/item?id=29455852。

### **复制**

Postgres 的标准复制使用 WAL 进行物理复制。MySQL 的标准复制使用 binlog 进行逻辑复制。

Postgres 也支持通过其发布/订阅模式进行逻辑复制。

### **JSON**

Postgres 和 MySQL 都支持 JSON。Postgres 支持的功能更多：

Both Postgres and MySQL supports JSON column. Postgres supports more features:

-   更多操作符来访问 JSON 功能。
    
-   允许在 JSON 字段上创建索引。
    

### **CTE (Common Table Expression)**

Postgres 对 CTE 的支持更全面：

-   在 CTE 内进行 SELECT, UPDATE, INSERT, DELETE 操作
    
-   在 CTE 之后进行 SELECT, UPDATE, INSERT, DELETE 操作
    

MySQL 支持：

-   在 CTE 内进行 SELECT 操作
    
-   在 CTE 之后进行 SELECT, UPDATE, DELETE 操作
    

### **窗口函数 (Window Functions)**

**窗口帧类型**：MySQL 仅支持 Row Frame 类型，允许定义由固定数量行组成的帧；而 Postgres 同时支持 Row Frame 和范围帧类型。

**范围单位**：MySQL 仅支持 UNBOUNDED PRECEDING 和 CURRENT ROW 这两种范围单位；而 Postgres 支持更多范围单位，包括 UNBOUNDED FOLLOWING 和 BETWEEN 等。

**性能**：一般来说，Postgres 实现的 Window Functions 比 MySQL 实现更高效且性能更好。

**高级函数**：Postgres 还支持更多高级 Window Functions，例如 LAG(), LEAD(), FIRST\_VALUE(), and LAST\_VALUE()。

  


## **可扩****展性 Extensibility**

Postgres 支持多种扩展。最出色的是 PostGIS，它为 Postgres 带来了地理空间能力。此外，还有 Foreign Data Wrapper (FDW)，支持查询其他数据系统，pg\_stat\_statements 用于跟踪规划和执行统计信息，pgvector 用于进行 AI 应用的向量搜索。

MySQL 具有可插拔的存储引擎架构，并诞生了 InnoDB。但如今，在 MySQL 中，InnoDB 已成为主导存储引擎，因此可插拔架构只作为 API 边界使用，而不是用于扩展目的。

在认证方面，Postgres 和 MySQL 都支持可插拔认证模块 (PAM)。

  


## **易用性 Usability**

Postgres 更加严格，而 MySQL 更加宽容：

-   MySQL 允许在使用 GROUP BY 子句的 SELECT 语句中包含非聚合列；而 Postgres 则不允许。
    
-   MySQL 默认情况下是大小写不敏感的；而 Postgres 默认情况下是大小写敏感的。
    
-   MySQL 允许 JOIN 来自不同数据库的表；而 Postgres 只能连接单个数据库内部的表，除非使用 FDW 扩展。



## **连接模型 Connection Model**

Postgres 采用在每个连接上生成一个新进程的方式工作。而 MySQL 则在每个连接上生成一个新线程。因此，Postgres 提供了更好的隔离性，例如，一个无效的内存访问错误只会导致单个进程崩溃，而不是整个数据库服务器。另一方面，进程模型消耗更多资源。因此，在部署 Postgres 时建议通过连接池（如 PgBouncer 或 pgcat）代理连接。


## **生态 Ecosystem**

常见的 SQL 工具都能很好地支持 Postgres 和 MySQL。由于 Postgres 的可扩展架构，并且仍被社区拥有，近年来 Postgres 生态系统更加繁荣。对于提供托管数据库服务的应用平台，每个都选择了 Postgres。从早期的 Heroku 到更新的 Supabase, render 和 Fly.io。


## **可运维性 Operability**

由于底层存储引擎设计问题，在高负载下，Postgres 存在臭名昭著的 XID wraparound 问题。

对于 MySQL，在 Google Cloud 运营大规模 MySQL 集群时，我们遇到过一些复制错误。

这些问题只会在极端负载下发生。对于正常工作负载而言，无论是 Postgres 还是 MySQL 都是成熟且可靠的。数据库托管平台也提供集成备份/恢复和监控功能。


## **Postgres 还是 MySQL**

2023 年了，在 Postgres 和 MySQL 之间做选择仍然很困难，并且经常引起激烈辩论 https://news.ycombinator.com/item?id=35906604。

总的来说，Postgres 有更多功能、更繁荣的社区和生态；而 MySQL 则更易学习并且拥有庞大的用户群体。

我们观察到了与 Stack Overflow 结果相同的行业趋势，即 Postgres 在开发者中变得越来越受欢迎。但根据我们的实际体验，精密的 Postgres 牺牲了一些便利性。如果你对 Postgres 不太熟悉，最好从云服务提供商那里启动一个实例，并运行几个查询来上手。有时候，这些额外好处可能并不值得，选择 MySQL 会更容易一些。

___

同时，在一个组织内部共存 Postgres 和 MySQL 也是很常见的情况。如果需要同时管理 Postgres 和 MySQL 的开发生命周期，欢迎来了解一下 [Bytebase](https://mp.weixin.qq.com/s?__biz=MzkzMjI2MDY5OQ==&mid=2247505156&idx=1&sn=a8eed11c0174c26cf9099827380edf10&chksm=c25ceb30f52b6226e1c2c0da6d7bfe9540c3da97c5a0b6e227c5e7a89ff0e7071ef1caa99f3f&scene=21#wechat_redirect)！