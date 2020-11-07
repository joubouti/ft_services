FROM mynginx

# RUN apk update && apk add php7-fpm php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom

RUN apk add phpmyadmin && apk add php7-fpm

COPY config.inc.php /tmp/

RUN rm /www/index.html && mv /usr/share/webapps/phpmyadmin/* /www/ && \
    mv /tmp/config.inc.php /www/ && chown -R www:www /www/

COPY nginx.conf /etc/nginx/


ENTRYPOINT php-fpm7 && nginx -g "daemon off;"
