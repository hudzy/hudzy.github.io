---
layout: post
title: "Why I’m Betting Against AI Agents in 2025 (Despite Building Them)"
date: 2025-07-26
tags: [笔记, 生活]
---

Original Post: [Why I'm Betting Against AI Agents in 2025 (Despite Building Them)](https://utkarshkanwat.com/writing/betting-against-agents/)

## 🚫 Cutting Through the Hype

Utkarsh Kanwat, a hands‑on AI engineer, has built **12+ production‑grade agent systems** across development, DevOps, data ops, CI/CD, and more. Despite this, he warns that 2025’s wave of **“fully autonomous AI agents”** is fundamentally flawed—the problems are mathematical, economic, and engineering‑level, not hype. ([Utkarsh Kanwat][1])

---

## 1. Error Compounding: The Reliability Gap

* If each agent step succeeds 95% of the time, a 20‑step chain yields only \~36% overall success.
* Production environments demand **99.9%+ reliability**, making multi‑step autonomous workflows unviable.
* His agent systems prevent these failures by using **bounded contexts, rollback points, verifiable operations**, and **human decision gates** for critical steps. ([Utkarsh Kanwat][1])

A Reddit reader captures the engineer’s skepticism succinctly:

> “99.9% sounds impressive to a non‑engineer. But one in a thousand is not rare at all.” ([Reddit][2])

---

## 2. Token Economics: The Quadratic Cost Trap

* **Conversational agents** require reprocessing the entire context on every interaction.
* Token cost grows **quadratically with conversation length**, so long sessions become cost‑prohibitive (e.g., \$50–100 per session by 100 turns).
* Stateless agents (e.g. “spec → function → done”) avoid this issue—no context buildup, negligible token inflation. ([Utkarsh Kanwat][1])

The tradeoff is clear: economic viability favors narrowly scoped, stateless agents over interactive dialogues.

---

## 3. Tool Engineering: The Unseen Majority

* AI tooling demands **engineered interfaces** that handle partial failures, state changes, and recovery logic.
* Raw API outputs are **too noisy** or verbose—agents need structured, compressed feedback to make correct decisions.
* Designing abstractions that report "10k rows returned, here are 5 examples" vs raw data requires effort.

According to Kanwat, **70% of the work** is in building these abstractions—not in model prompts. ([Utkarsh Kanwat][1])

---

## 4. Integration: The Enterprise Trap

* Real-world systems are messy: legacy APIs, varying auth flows, rate limits, inconsistent behaviors, permissions, and compliance demands.
* Kanwat’s agents layer on **connection pooling**, **transaction management**, **timeout logic**, **audit logs**, and more—typical “agent” solutions gloss over these.
* Integration complexity, he argues, is where most proposed autonomous agents fail in production. ([Utkarsh Kanwat][1])

---

## ✅ What *Actually* Works

Kanwat emphasizes that effective agents share these traits:

* **Human-in-the-loop at key points**: users review UI, approve destructive operations, or verify pull requests.
* **Clear scope and bounds**: a tool that does *one thing well*, like generating a React component or Terraform, then finishes. No chaining or state leakage.
* **Robust feedback and rollback mechanisms**: each operation is verifiable, auditable, and recoverable.
* **AI for generating intent or content**, traditional engineering for execution and safety. ([Utkarsh Kanwat][1])

---

## 🛠 Key Engineering Lessons

For engineers building or evaluating agentic systems:

| Principle                                | Summary                                                              |
| ---------------------------------------- | -------------------------------------------------------------------- |
| **Define boundaries**                    | Clearly scope agent responsibility; avoid chaining too many steps    |
| **Design for failure**                   | Include rollbacks and checkpoints                                    |
| **Mind token economics**                 | Stateless designs are cheaper and more reliable                      |
| **Prioritize reliability over autonomy** | Users trust consistent systems more than occasional magic            |
| **Build tooling layers**                 | Input filtering, state summarization, error feedback—engineered well |

---

## 🔮 Market & Organizational Outlook

* Venture‑backed startups promising full autonomy may struggle with scale and burn through capital.
* Enterprise vendors who bolt agents onto existing stacks will face **integration stagnation**.
* Winners will be teams building **specialized, constrained assistants**, not general‑purpose agent platforms. ([Utkarsh Kanwat][1])

The conclusion? The future lies in **hybrid models**—AI-driven productivity with engineering controls, not blind autonomy.

---

### 🧠 From a Computer Engineer Lens

* The article scratches below the surface: it’s not about training bigger models, but about designing **software systems** that can use AI safely and efficiently.
* The real engineering challenge is about **workflow orchestration, feedback loops, observability, and cost control**.
* If you're building AI‑powered tools, start with **clear module boundaries**, **statelessness where possible**, and **deterministic infrastructure scaffolding**.

---

### 💬 Community Perspective

On Reddit:

> “The compounding error problem is indeed real… Most ideas fall apart before you get to 100.”
> “The ones reliable enough to make it into production are dumb. Not exciting at all.” ([Reddit][2])

---

### ✅ Final Summary

* **Not anti‑AI**, but bullish on **right‑headed AI architecture**.
* Autonomous agents as hyped may be mathematically and economically infeasible.
* The successful pattern lies in **bounded scope, human oversight, engineered feedback loops**, and **traditional software reliability**.
* As you build, focus on **real world constraints**, not demos.

Let me know if you’d like help translating any of these constraints into system architecture or code patterns!

[1]: https://utkarshkanwat.com/writing/betting-against-agents/?utm_source=chatgpt.com "Why I'm Betting Against AI Agents in 2025 (Despite Building Them)"
[2]: https://www.reddit.com/r/programming/comments/1m46lfb/why_im_betting_against_ai_agents_in_2025_despite/?utm_source=chatgpt.com "Why I'm Betting Against AI Agents in 2025 (Despite Building Them)"
