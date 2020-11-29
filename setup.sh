#!bin/bash

eval $(minikube docker-env)

minikube addons enable metallb

eval $(minikube docker-env)

export MINIKUBE_IP=$(minikube ip)

docker build -t mynginx -f images/nginx/nginx.dockerfile images/nginx
docker build -t main-nginx images/nginx
docker build -t mysqldb images/mysql 
docker build -t mywp images/wordpress
docker build -t mypma images/phpMyAdmin
docker build -t mytelegraf --build-arg INCOMING=${MINIKUBE_IP} images/telegraf
docker build -t myinfluxdb images/influxdb
docker build -t mygrafana images/grafana

kubectl delete svc/wordpress
kubectl delete svc/phpmyadmin
kubectl delete svc/nginx
kubectl delete svc/mysql
kubectl delete svc/grafana
kubectl delete svc/influxdb
kubectl delete deploy/wordpress
kubectl delete deploy/phpmyadmin
kubectl delete deploy/nginx
kubectl delete deploy/mysql
kubectl delete deploy/telegraf
kubectl delete deploy/influxdb
kubectl delete deploy/grafana


kubectl apply -f nginx-deployment.yaml  
kubectl apply -f mysql-deployment.yaml  
kubectl apply -f wordpress-deployment.yaml 
kubectl apply -f phpmyadmin-deployment.yaml
kubectl apply -f grafana-deployment.yaml
kubectl apply -f influxdb-deployment.yaml
kubectl apply -f telegraf-deployment.yaml
kubectl apply -f metallb-config.yaml  
