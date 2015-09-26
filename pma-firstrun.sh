sed -i 's|$PMA_USERNAME|'"$PMA_USERNAME"'|g' /usr/share/nginx/html/sql/create_user.sql
sed -i 's|$PMA_PASSWORD|'"$PMA_PASSWORD"'|g' /usr/share/nginx/html/sql/create_user.sql

mysql --host=$MYSQL_PORT_3306_TCP_ADDR --port=$MYSQL_PORT_3306_TCP_PORT --user=root --password=$MYSQL_ENV_MYSQL_ROOT_PASSWORD < /usr/share/nginx/html/sql/create_tables.sql
mysql --host=$MYSQL_PORT_3306_TCP_ADDR --port=$MYSQL_PORT_3306_TCP_PORT --user=root --password=$MYSQL_ENV_MYSQL_ROOT_PASSWORD < /usr/share/nginx/html/sql/create_user.sql

rm -f /pma-firstrun.sh
