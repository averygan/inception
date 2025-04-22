#!/bin/bash

echo "Starting MariaDB server"
service mariadb start

echo "Initializing database"

sleep 5

mariadb -v -u root << EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_PASSWORD');
EOF

echo "MariaDB initialization complete. Starting server"
service mariadb stop
exec mysqld_safe