# DOCKER PHPMYADMIN

> nginx `1.8.x` + php5-fpm `5.6.x` + mysql `5.7.8-rc` + phpmyadmin `4.4.14.1`

## 创建 MySQL 容器

```
docker run --name mysql \
-e "MYSQL_ROOT_PASSWORD=123456" \
-e "MYSQL_USER=wangyan" \
-e "MYSQL_PASSWORD=123456" \
-d myidwy/docker-mysql
```

支持的环境变量:

- MYSQL_ROOT_PASSWORD
- MYSQL_DATABASE
- MYSQL_USER
- MYSQL_PASSWORD
- MYSQL_ALLOW_EMPTY_PASSWORD 

更多信息：[https://github.com/docker-library/docs/tree/master/mysql](https://github.com/docker-library/docs/tree/master/mysql)


```
docker logs -f mysql //查日志
```

```
docker exec -it mysql /bin/bash //进入容器
```



## 创建 phpMyAdmin 容器

```
docker run --name phpMyAdmin \
--link wy-mysql:mysql \
-P -d myidwy/docker-phpmyadmin
```

## 运行 mysqladmin

```
docker run --link MySQL:MySQL myidwy/docker-phpmyadmin -uroot -p123456 status;
```

## 其他

```
docker rm -f $(docker ps -a -q)
```

```
docker rmi -f myidwy/docker-phpmyadmin
```