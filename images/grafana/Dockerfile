FROM alpine:3.12.1

COPY grafana.db /tmp/

RUN apk add -X http://nl.alpinelinux.org/alpine/edge/testing grafana && \
    mkdir /usr/share/grafana/data && \
    mv /tmp/grafana.db /usr/share/grafana/data/

CMD grafana-server -config /etc/grafana.ini -homepath /usr/share/grafana/
