#!/bin/sh

if [ -d /var/lib/mysql/wordpress ] ;
then
        echo "DATABASE ALREADY EXISTS" >> /root/isExist
else
        echo "DATABASE DOES NOT EXIST" >> /root/isExist
        mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

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

fi
rm /etc/my.cnf.d/mariadb-server.cnf
mv /tmp/my.cnf /etc/my.cnf.d/mariadb-server.cnf
mysqld --user=mysql

# mysql -upma_user -p1234 -h mysqlhost