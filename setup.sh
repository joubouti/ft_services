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
kubectl delete deploy/c-wp
kubectl delete deploy/c-pma
kubectl delete deploy/c-nginx
kubectl delete deploy/c-mysql
kubectl delete deploy/c-telegraf
kubectl delete deploy/c-influxdb
kubectl delete deploy/c-grafana


kubectl apply -f metallb-config.yaml  
kubectl apply -f nginx-deployment.yaml  
kubectl apply -f mysql-deployment.yaml  
kubectl apply -f wordpress-deployment.yaml 
kubectl apply -f phpmyadmin-deployment.yaml
kubectl apply -f grafana-deployment.yaml
kubectl apply -f influxdb-deployment.yaml
kubectl apply -f telegraf-deployment.yaml
