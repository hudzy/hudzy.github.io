---
layout: post
title: "xiaoya-alist简单部署教程"
date: 2023-10-13
tags: [笔记, 折腾]
---

[官方完整教程](https://www.notion.so/xiaoya-docker-69404af849504fa5bcf9f2dd5ecaa75f)

准备条件:
  - docker运行环境
  - 阿里云账号

开始:
  1. 创建三个文件:
    - mytoken.txt
    - myopentoken.txt
    - temp_transfer_folder_id.txt

  2. 文件值:
    - mytoken.txt: https://aliyuntoken.vercel.app/
    - myopentoken.txt: https://alist.nn.ci/tool/aliyundrive/request.html
    - temp_transfer_folder_id.txt: https://www.notion.so/xiaoya-docker-69404af849504fa5bcf9f2dd5ecaa75f#bc572531d09e4baa80afdf3f52653c7d

  3. 启动容器:
    - linux: docker run -d -p 6091:80 -v /mnt/mmcblk2p4/xiaoya/data:/data --restart=always --name=xiaoya xiaoyaliu/alist:latest
    - windows: docker run -d -p 6091:80 -v //c/Users/xxx/Downloads/xiaoya-data:/data --name=xiaoya xiaoyaliu/alist:latest

  4. 使用webdav客户端挂载http://服务IP:6091/dav，用户: guest 密码: guest_Api789