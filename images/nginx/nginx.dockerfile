FROM alpine:3.12.1
# VOLUME /sys/fs/cgroup
RUN mkdir -p /run/nginx
RUN apk update && apk add openrc --no-cache && apk add nginx vim curl && adduser -D -g 'www' www && mkdir /www
RUN chown -R www:www /var/lib/nginx && chown -R www:www /www

# RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
# COPY nginx.conf /etc/nginx/

COPY ssl/self-signed.conf /etc/nginx/snippets/self-signed.conf
COPY ssl/ssl-params.conf /etc/nginx/snippets/ssl-params.conf
COPY ssl/dhparam.pem /etc/ssl/certs/dhparam.pem
COPY ssl/nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key
COPY ssl/nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt

COPY index.html /www/
CMD ["nginx", "-g", "daemon off;"]