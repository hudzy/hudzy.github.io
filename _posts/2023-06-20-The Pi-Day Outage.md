---
layout: post
title: "You Broke Reddit: The Pi-Day Outage"
date: 2023-06-20
tags: [笔记, 工作]
---

分享一个很有意思的文章：

[You Broke Reddit: The Pi-Day Outage](https://www.reddit.com/r/RedditEng/comments/11xx5o0/you_broke_reddit_the_piday_outage/)

我来帮大家快读一遍，大概是这样的：在3月14日，reddit在美国时间下午down了一段时间，工程师在尝试现场修复未果后恢复备份，以下是对这次事件的调查结果：

Reddit使用Kubernetes进行容器调度，在事故发生的时候，工程师团队正在尝试将生产环境的Kubernetes从`1.23`版本升级为`1.24`，虽然他们在测试集群已经演练过多次，但是升级后的生产集群却无法接受网络请求，工程师在2个多小时的各种debug（包括尝试重启大法）后无果，于是回滚集群版本，恢复备份数据。

调查发现，事故的原因在于集群使用的CNI网络插件Calico的配置里面，对于reflectors(Calico的一个组件，用来广播Calico配置)选择，使用的node label是`nodeSelector: has(node-role.kubernetes.io/master)`。但是，受“政治正确”的影响，在Kubernetes版本`1.20`起，deprecate了`node-role.kubernetes.io/master`，改为使用`node-role.kubernetes.io/control-plane`，两个label同时保留，直到`1.24`版本起，彻底retire`node-role.kubernetes.io/master`，[reference](https://github.com/kubernetes/enhancements/tree/master/keps/sig-cluster-lifecycle/kubeadm/2067-rename-master-label-taint) 。所以当Kubernetes版本更新后，Calico无法正确匹配到node，于是造成了这个事故。

这是我第一次看到因为“政治正确”引发的生产事故，感觉很有意思，记录下来并分享。
