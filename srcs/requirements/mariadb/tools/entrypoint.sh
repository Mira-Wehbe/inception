#!/bin/bash
set -e

DATA_DIR="/var/lib/mysql"

if [ ! -d "$DATA_DIR/mysql" ]; then
    echo "Initializing MariaDB system tables..."
    mysql_install_db --user=mysql --datadir="$DATA_DIR"
fi

mysqld --user=mysql --skip-networking &
MYSQL_PID=$!

until mysqladmin ping --silent; do
    sleep 1
done

if [ ! -d "$DATA_DIR/${MYSQL_DATABASE}" ]; then
    mysql -u root <<MYSQL_SCRIPT
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT
fi

mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
wait $MYSQL_PID

echo "Starting MariaDB in foreground:)"
exec mysqld --user=mysql
