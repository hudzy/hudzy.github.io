---
layout: post
title: "Docker container name"
date: 2023-08-25
tags: [笔记, 工作]
---

When creating a Docker container, if its name is not specified, docker will randomly generate a name: two words with a underscore, you take it as it is, **but how**?

There is a [namesgenerator](https://github.com/moby/moby/blob/master/pkg/namesgenerator/names-generator.go) package on [moby](https://github.com/moby/moby/)(A.K.A. Docker) project, it uses a list of adjectives for left word and a list of notable scientists and hackers for right word. If the generated combination is used, the new container name will be added with a random number from 0 to 10.

This list was [frozen](https://github.com/moby/moby/pull/43210#issuecomment-1029934277) on Feb 11, 2022, because it's `more and more complicated to keep the list inclusive, diverse, and balanced`.

Going through the file history, there are some interesting ones:

- [0f052eb](https://github.com/moby/moby/commit/0f052eb4f56c05dcb8c444823ebde6ce0fac7197): Remove Valentina Tereshkova after the frozen. She is a Russian engineer, cosmonaut and politician, and voted for the Russian invasion of Ukraine.
- [4bfd23b](https://github.com/moby/moby/commit/4bfd23b7ee5f053a4e45b4b016144690c683ce1e): Add Satoshi Nakamoto. This name was used by the unknown person or group of people who developed bitcoin.
- [7015fc0](https://github.com/moby/moby/commit/7015fc03b72655e9484e68b4ec64b5fca80c68a0): Fixed comment spacing for the OCD people.
