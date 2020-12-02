#!bin/bash



rm -rf ~/.minikube
mkdir -p ~/goinfre/.minikube

ln -s ~/goinfre/.minikube ~/.minikube

minikube delete
minikube start	--vm-driver=virtualbox \
				--cpus=2 --memory 3000 \


minikube addons enable metallb
minikube addons enable dashboard

eval $(minikube docker-env)

export MINIKUBE_IP=$(minikube ip)

docker build -t mynginx -f srcs/images/nginx/nginx.dockerfile srcs/images/nginx
docker build -t main-nginx srcs/images/nginx
docker build -t mysqldb srcs/images/mysql 
docker build -t mywp srcs/images/wordpress
docker build -t mypma srcs/images/phpMyAdmin
docker build -t myftps srcs/images/ftps
docker build -t myinfluxdb --build-arg INCOMING=${MINIKUBE_IP} srcs/images/influxdb
docker build -t mygrafana srcs/images/grafana


kubectl apply -f srcs/nginx-deployment.yaml  
kubectl apply -f srcs/mysql-deployment.yaml  
kubectl apply -f srcs/wordpress-deployment.yaml 
kubectl apply -f srcs/phpmyadmin-deployment.yaml
kubectl apply -f srcs/grafana-deployment.yaml
kubectl apply -f srcs/influxdb-deployment.yaml
kubectl apply -f srcs/ftps-deployment.yaml
kubectl apply -f srcs/metallb-config.yaml  
