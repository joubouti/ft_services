FROM alpine:3.12.1

RUN apk update && apk add su-exec mysql mysql-client 
# COPY my.cnf /etc/mysql/my.cnf
RUN mkdir /run/mysqld && chown -R mysql:mysql /run/mysqld
# RUN mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

COPY start.sh /tmp/
COPY wordpress.sql /tmp/

# RUN sh /tmp/start.sh

# RUN rm /etc/my.cnf.d/mariadb-server.cnf
COPY my.cnf /tmp/


RUN mkdir /ssl
COPY ssl/ca-cert.pem /ssl
COPY ssl/server-cert.pem /ssl
COPY ssl/server-key.pem /ssl

# RUN sh /tmp/start.sh
# RUN mysqld --user=mysql > /dev/null 2>&1 & ; sh /tmp/start.sh
VOLUME /var/lib/mysql

EXPOSE 3306

ENTRYPOINT ["sh", "/tmp/start.sh"]