FROM mynginx

RUN apk add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype

RUN cd /www && rm index.html && wget -c http://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz \
    && mv wordpress/* . && rm -rf latest.tar.gz wordpress && chown -R www:www .
COPY wp-config.php /www/
COPY start.sh /tmp/

# RUN rc-update add php-fpm7 default
COPY nginx.conf /etc/nginx/

CMD ["sh", "/tmp/start.sh"]
