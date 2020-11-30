FROM alpine:3.12.1

ARG INCOMING
ENV MINIKUBE_IP=${INCOMING}

RUN apk add bash && mkdir /influxdb && cd /influxdb && wget https://dl.influxdata.com/influxdb/releases/influxdb-2.0.0-rc.3_linux_amd64.tar.gz && \
    tar xvzf influxdb-2.0.0-rc.3_linux_amd64.tar.gz && rm influxdb-2.0.0-rc.3_linux_amd64.tar.gz && \
    mv influxdb-2.0.0-rc.3_linux_amd64/* . && rmdir influxdb-2.0.0-rc.3_linux_amd64 && \
    mkdir /telegraf && cd /telegraf && wget https://dl.influxdata.com/telegraf/releases/telegraf-1.16.1_linux_i386.tar.gz && \
    tar xf telegraf-1.16.1_linux_i386.tar.gz && mv telegraf-1.16.1/* . && \
    rm telegraf-1.16.1_linux_i386.tar.gz && rmdir telegraf-1.16.1


COPY backup /tmp/
COPY start.sh /root/
COPY telegraf.conf /telegraf/etc/telegraf/telegraf.conf
# COPY backup /root/.influxdbv2
# COPY telegraf.conf /telegraf/etc/telegraf/
# COPY telegraf.conf /telegraf/telegraf-1.16.1/etc/telegraf/telegraf.conf
# RUN echo $'#!/bin/sh \n\
# /influxdb/influxd & \n\
# /influxdb/influx setup -u admin -p 123456789 -o 1337 -b mybucket -f' >> /tmp/setup.sh && sh /tmp/setup.sh
VOLUME /root/.influxdbv2
# curl -k --cacert $CA_CERT -H "Authorization: Bearer $TOKEN" https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT/api/v1/namespaces/default/pods
ENTRYPOINT ["sh", "/root/start.sh"]
CMD /telegraf/usr/bin/telegraf --config /telegraf/etc/telegraf/telegraf.conf