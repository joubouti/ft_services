#!/bin/sh

mysqld --user=mysql & 

mysqladmin --silent --wait=30 ping || exit 1

mysql -uroot -p1234 -e "CREATE DATABASE wordpress;" \
                    -e "CREATE DATABASE phpmyadmin;"

mysql -uroot -p1234 wordpress < /tmp/wordpress.sql

# echo HELLO > /tmp/HELLO

mysql -uroot -p1234 -e "CREATE USER 'wp_user'@'%' IDENTIFIED BY '1234';" \
                    -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%' WITH GRANT OPTION;" \
                    -e "CREATE USER 'pma_user'@'%' IDENTIFIED BY '1234';" \
                    -e "GRANT ALL PRIVILEGES ON *.* TO 'pma_user'@'%' WITH GRANT OPTION;" \
                    -e "FLUSH PRIVILEGES;" \

            #  -e "CREATE DATABASE wordpress;" \
            #  -e "CREATE DATABASE phpmyadmin;" \

pkill mysqld
# mysqld --user=mysql

# mysql -upma_user -p1234 -h mysqlhost