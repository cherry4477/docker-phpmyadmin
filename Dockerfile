FROM myidwy/nginx-php:latest
MAINTAINER WangYan <i@wangyan.org>

ENV PMA_SECRET          phpMyAdmin
ENV PMA_USERNAME        pma
ENV PMA_PASSWORD        pwd123#PMA
ENV MYSQL_USERNAME      mysql
ENV MYSQL_PASSWORD      pwd123#MySQL

RUN apt-get update && \
    apt-get install -y mysql-client && \
    rm -rf /var/lib/apt/lists/*

RUN rm -rf /usr/share/nginx/html && \
    PMA_VERSION=$(curl -sk https://www.phpmyadmin.net/downloads/ | awk '/phpMyAdmin 4/{print $2}'| cut -d '<' -f 1 | head -1) && \
    curl -kO https://files.phpmyadmin.net/phpMyAdmin/${PMA_VERSION}/phpMyAdmin-${PMA_VERSION}-all-languages.tar.gz && \
    tar -zxf phpMyAdmin-${PMA_VERSION}-all-languages.tar.gz && \
    mv phpMyAdmin-${PMA_VERSION}-all-languages /usr/share/nginx/html && \
    rm -f phpMyAdmin-${PMA_VERSION}-all-languages.tar.gz

WORKDIR /usr/share/nginx/html

COPY ./config.inc.php ./config.inc.php
COPY ./create_user.sql ./sql/create_user.sql
COPY ./entrypoint.sh /entrypoint.sh
COPY ./pma-firstrun.sh /pma-firstrun.sh

RUN chmod +x /entrypoint.sh && chmod +x /pma-firstrun.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80

CMD ["phpmyadmin"]