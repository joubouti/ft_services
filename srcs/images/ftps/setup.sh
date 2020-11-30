#!/bin/sh
# export TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
# export HOST_IP=$(curl -s $API_URL/api/v1/namespaces/$POD_NAMESPACE/pods/$HOSTNAME --header "Authorization: Bearer $TOKEN" --insecure | jq -r '.status.hostIP')

adduser -D -h /var/ftp ftp_user1
adduser -D -h / ftp_user2
echo "ftp_user1:1234" | chpasswd
echo "ftp_user2:1234" | chpasswd

vsftpd /etc/vsftpd/vsftpd.conf
