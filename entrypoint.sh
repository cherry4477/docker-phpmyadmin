#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
  set mysqladmin -h$MYSQL_PORT_3306_TCP_ADDR -P$MYSQL_PORT_3306_TCP_PORT "$@"
fi

if [ "$1" = 'phpmyadmin' ]; then
  if [ -f "/pma-firstrun.sh" ]; then
    /pma-firstrun.sh
  fi

  sed -i \
      -e "s|\$PMA_SECRET|$PMA_SECRET|g" \
      -e "s|\$PMA_USERNAME|$PMA_USERNAME|g" \
      -e "s|\$PMA_PASSWORD|$PMA_PASSWORD|g" \
      -e "s|\$MYSQL_PORT_3306_TCP_ADDR|$MYSQL_PORT_3306_TCP_ADDR|g" \
      -e "s|\$MYSQL_PORT_3306_TCP_PORT|$MYSQL_PORT_3306_TCP_PORT|g" \
      /usr/share/nginx/html/config.inc.php

  service php5-fpm start
  exec nginx -g "daemon off;"
fi

exec "$@"
