#!/bin/bash

echo "Starting script..."
echo "This script provides start nginx server using minikube (k8s kubectl)."
POD_NAME="nginx-pod"
SERVICE_NAME="nginx-service"

# Проверка на состояние minikube
STATUS=$(minikube status | grep -i "host:" | awk '{print $2}')
if [ "$STATUS" == "Stopped" ]; then
    echo "Minikube не запущен. Запускаем Minikube..."
    minikube start
fi

# Проверка наличия пода
echo "Выполняется запуск nginx-pod and nginx-service..."
POD_EXISTS=$(kubectl get pods --no-headers | awk '{print $1}' | grep "^$POD_NAME$")
if [ -n "$POD_EXISTS" ]; then
    echo "Под $POD_NAME существует."
else
    echo "Под $POD_NAME не найден."
    kubectl apply -f ./yaml-files/nginx-pod.yaml
fi


# Проверка наличия сервиса
SERVICE_EXISTS=$(kubectl get services --no-headers | awk '{print $1}' | grep "^$SERVICE_NAME$")
if [ -n "$SERVICE_EXISTS" ]; then
    echo "Сервис $SERVICE_NAME существует."
else
    echo "Сервис $SERVICE_NAME не найден."
    kubectl apply -f ./yaml-files/nginx-service.yaml
fi

echo " "
# Просмотр списков подов и сервисов
echo "EXEC get pods & get service"
kubectl get pods
kubectl get services

echo "Проверка... Дожидаемся, пока pod не будет запущен..." 
# Проверяем статус пода
while true; do
    STATUS=$(kubectl get pod "$POD_NAME" --no-headers | awk '{print $3}')

    if [ "$STATUS" = "Running" ]; then
        echo "Под $POD_NAME запущен и имеет статус Running."
        break
    else
        echo "Под $POD_NAME в статусе $STATUS. Повторная проверка через 2 секунды..."
        sleep 2
    fi
done

echo "Сейчас откроется окно браузера!"
#kubectl exec -it "$POD_NAME" -- curl localhost:80
minikube service "$SERVICE_NAME"