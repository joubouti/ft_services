FROM alpine:3.12.1

RUN apk upgrade
RUN apk add vsftpd

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY vsftpd.crt /etc/ssl/certs/
COPY vsftpd.key /etc/ssl/private/
COPY setup.sh /tmp/
# RUN chmod +x /tmp/setup.sh

EXPOSE 20 21 30000

ENTRYPOINT ["sh", "/tmp/setup.sh"]
