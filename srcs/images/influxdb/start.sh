#!/bin/bash

if [ -f /root/.influxdbv2/configs ] ;
then
        echo "DATABASE ALREADY EXISTS" >> /root/isExist
else
        echo "DATABASE DOES NOT EXIST" >> /root/isExist
        mkdir /root/.influxdbv2
        cp /tmp/* /root/.influxdbv2/
fi

/influxdb/influxd &
# influxd
exec "$@"
# mysql -upma_user -p1234 -h mysqlhost