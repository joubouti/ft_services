#!/bin/sh

while true; do
    if [ -z "$(pgrep 'php-fpm7')"]; then
        php-fpm7 &
    fi
    if [ -z "$(pgrep 'nginx -g daemon off;')"]; then
        nginx -g "daemon off;" &
    fi
    sleep 2
done
