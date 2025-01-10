#!/bin/bash

echo "Starting script..."
echo "This script provides delete nginx full configuration and stop minikube."
POD_NAME="nginx-pod"
SERVICE_NAME="nginx-service"

# Проверка на состояние minikube
STATUS=$(minikube status | grep -i "host:" | awk '{print $2}')
if [ "$STATUS" == "Stopped" ]; then
    echo -e "\nMinikube не запущен. Запускаем Minikube..."
    minikube start
fi

# Проверка наличия пода
echo -e "\nВыполняется удаление nginx-pod and nginx-service..."
POD_EXISTS=$(kubectl get pods --no-headers | awk '{print $1}' | grep "^$POD_NAME$")
if [ -n "$POD_EXISTS" ]; then
    echo "Под $POD_NAME существует."
    kubectl delete -f ./yaml-files/nginx-pod.yaml
else
    echo "Под $POD_NAME не найден."
fi

# Проверка наличия сервиса
SERVICE_EXISTS=$(kubectl get services --no-headers | awk '{print $1}' | grep "^$SERVICE_NAME$")
if [ -n "$SERVICE_EXISTS" ]; then
    echo "Сервис $SERVICE_NAME существует."
    kubectl delete -f ./yaml-files/nginx-service.yaml
else
    echo "Сервис $SERVICE_NAME не найден."
fi

# Просмотр списков подов и сервисов
echo -e "\nEXEC get pods & get service"
kubectl get pods
kubectl get services

# Остановка minikube
echo -e "\nОстановка minikube..."
minikube stop

echo -e "\nНа этом выполнение скрипта $0 завершается!"