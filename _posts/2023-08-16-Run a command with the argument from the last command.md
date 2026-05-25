---
layout: post
title: "Run a command with the argument from the last command"
date: 2023-08-16
tags: [笔记, 工作]
---

There are a few shortcuts if you want all of the arguments from the previous command, or just the last argument.

-   For all of the arguments: `<command> !*`
-   For just the last argument: `<command> !$`

If you want a single argument from a list of arguments from the previous command, you can use `<command> !:<argNumber>`, You can also use `!^` in place of `!:1`.

Example:

```bash
ls foo/ bar/ baz/
ls !:2 # Gives the results of ls bar/
ls foo/ bar/ baz/
ls !:1 # Gives the results of ls foo/
```