---
layout: post
title: "Understanding resource limits in kubernetes: memory and cpu"
date: 2023-08-15
tags: [笔记, 工作]
---
# Understanding resource limits in kubernetes: memory and cpu

https://medium.com/@betz.mark/understanding-resource-limits-in-kubernetes-memory-6b41e9a955f9

https://medium.com/@betz.mark/understanding-resource-limits-in-kubernetes-cpu-time-9eff74d3161b

memory - limit: /sys/fs/cgroup/memory/kubepods/burstable/xxx/memory.limit_in_bytes
memory - request: used for kube scheduler to determine nodes
cpu - limit: /sys/fs/cgroup/cpu,cpuacct/kubepods/burstable/xxx/cpu.cfs_period_us and /sys/fs/cgroup/cpu,cpuacct/kubepods/burstable/xxx/cpu.cfs_quota_us
cpu - request: /sys/fs/cgroup/cpu,cpuacct/kubepods/burstable/xxx/cpu.shares