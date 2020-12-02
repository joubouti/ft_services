#!/bin/bash

if [ -f /root/.influxdbv2/configs ] ;
then
        echo "DATABASE ALREADY EXISTS" >> /root/isExist
else
        echo "DATABASE DOES NOT EXIST" >> /root/isExist
        mkdir /root/.influxdbv2
        cp /tmp/* /root/.influxdbv2/
fi

while true; do
    if [ -z "$(pgrep '/influxdb/influxd')"]; then
        /influxdb/influxd &
    fi
    if [ -z "$(pgrep '/telegraf/usr/bin/telegraf')"]; then
        /telegraf/usr/bin/telegraf --config /telegraf/etc/telegraf/telegraf.conf &
    fi
    sleep 2
done
