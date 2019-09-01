Docer-compse(springboot, redis, nginx, mysql)

## 搭建springboot项目

集成mybatis、redis

参考项目源码，application.yml配置如下

```yaml
server:
  port: 8888
spring:
  thymeleaf:
    #开发配置为false,避免修改模板还要重启服务器
    cache: false
    #配置模板路径，默认是templates，可以不用配置
    prefix: classpath:/templates/
  redis:
    host: 127.0.0.1
    port: 6379
    lettuce:
      pool:
        # 连接池最大连接数（使用负值表示没有限制）d
        max-active: 8
        # 连接池最大阻塞等待时间（使用负值表示没有限制）
        max-wait: -1
        # 连接池中的最大空闲连接
        max-idle: 8
        # 连接池中的最小空闲连接
        min-idle: 0

  datasource:
    url: jdbc:mysql://localhost:3306/test
    username: root
    password: root
```

## 安装docker-compose

参考官方

## 创建工程目录

```bash
.
├── code
│   ├── Dockerfile
│   ├── application-docker.yml
│   └── springboot-docker.jar
├── db
│   └── mysql
├── docker-compose.yml
├── nginx
│   ├── conf.d
│   └── nginx.conf
└── redis
    ├── conf
    └── data
```

## 配置 docker-compose.yml 

```yml
version: '3.7'
services:
  code:
    build: code
    depends_on:
      - redis
      - db
  nginx:
    image: nginx
    restart: always
    volumes:
      - $PWD/nginx/conf.d/:/etc/nginx/conf.d/
      - $PWD/nginx/nginx.conf:/etc/nginx/nginx.conf
    ports:
      - "80:80"
      - "8887:8887"
    depends_on:
      - code
  redis:
    image: redis
    restart: always
    volumes: 
      - $PWD/redis/conf:/conf
      - $PWD/redis/data:/data
    ports:
      - "6379"
    command:
      redis-server /conf/redis.conf
  db:
    image: mysql/mysql-server:5.7
    volumes:
      - $PWD/db/mysql:/var/lib/mysql
    environment:
      MYSQL_DATABASE: test
      MYSQL_ROOT_PASSWORD: root
      MYSQL_ROOT_HOST: '%'
    restart: always
    ports:
      - "3307:3306"
```

##  配置 application-docker.yml

```yml
server:
  port: 8888
spring:
  thymeleaf:
    #开发配置为false,避免修改模板还要重启服务器
    cache: false
    #配置模板路径，默认是templates，可以不用配置
    prefix: classpath:/templates/
  redis:
    host: redis
    port: 6379
    lettuce:
      pool:
        # 连接池最大连接数（使用负值表示没有限制）d
        max-active: 8
        # 连接池最大阻塞等待时间（使用负值表示没有限制）
        max-wait: -1
        # 连接池中的最大空闲连接
        max-idle: 8
        # 连接池中的最小空闲连接
        min-idle: 0

  datasource:
    url: jdbc:mysql://db:3306/test
    username: root
    password: root
```

注意事项：

 redis.host = redis 表示访问docker-compose.yml中的redis服务

 datasource.url.jdbc:mysql://db:3306/test 表示访问docker-compose.yml中的db服务

## 配置 nginx.conf

```
http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    include /etc/nginx/conf.d/*.conf;

    server {
        listen 8887;
        server_name localhost;
        
        location / {
	          proxy_pass http://code:8888;
        }
    }
}
```

注意事项：

proxy_pass http://code:8888; 表示访问docker-compose.yml中的code服务

## 启动并访问

1. http://localhost:8887/db 

```json
[
    {
        "id":2,
        "name":"测试用户931237535"
    },
    {
        "id":3,
        "name":"测试用户-993266589"
    },
    {
        "id":4,
        "name":"测试用户-1129243697"
    },
    {
        "id":5,
        "name":"测试用户631082338"
    },
    {
        "id":6,
        "name":"测试用户570788101"
    },
    {
        "id":7,
        "name":"测试用户245252503"
    },
    {
        "id":8,
        "name":"测试用户-395260143"
    },
    {
        "id":9,
        "name":"测试用户-1323382877"
    },
    {
        "id":10,
        "name":"测试用户1191452461"
    }
]
```

2. http://localhost:8887/redis

