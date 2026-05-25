---
layout: post
title: "NGINX Rate Limiting"
date: 2023-08-23
tags: [笔记, 工作]
---

```
# https://nginx.org/en/docs/http/ngx_http_limit_req_module.html
limit_req_status 429;
limit_req_zone $binary_remote_addr zone=reqzone1:10m rate=1r/s;
limit_req_zone $server_name zone=reqzone2:10m rate=100r/s;
```

```
# http://nginx.org/en/docs/http/ngx_http_limit_conn_module.html
limit_conn_status 429;
limit_conn_zone $binary_remote_addr zone=connzone1:10m;
limit_conn_zone $server_name zone=connzone2:10m;
```

```
server {
    listen       80;
    server_name _;
    server_tokens   off;

    # DDOS protection
    client_body_timeout 20s;
    client_header_timeout 20s;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;

        # DDOS protection
        limit_req zone=reqzone1 burst=10 nodelay;
        limit_req zone=reqzone2 burst=10 nodelay;
        limit_conn connzone1 1;
        limit_conn connzone2 1000;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```