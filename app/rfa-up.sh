#!/bin/bash

echo "Starting reivn-fastapi-up.sh script ("${0}")..."
echo "This script provides start fastapi using minikube (kubectl)."
DEPLOYMENT_NAME="reivn-fastapi-app"
SERVICE_NAME="reivn-fastapi-service"

# Проверка на состояние minikube
STATUS=$(minikube status | grep -i "host:" | awk '{print $2}')
if [ "$STATUS" == "Stopped" ]; then
    echo -e "\nMinikube не запущен. Запускаем Minikube..."
    minikube start
fi

# Проверка наличия пода
echo -e "\nВыполняется запуск nginx-pod and nginx-service..."
POD_EXISTS=$(kubectl get pods -l app=$DEPLOYMENT_NAME -o jsonpath="{.items[0].metadata.name}")
if [ -n "$POD_EXISTS" ]; then
    echo "Под $POD_EXISTS существует."
    kubectl apply -f ./deployment.yaml
else
    echo "Под $POD_EXISTS не найден."
    kubectl apply -f ./deployment.yaml
fi

# Просмотр списков подов и сервисов
echo -e "\nkubectl get pods & get service..." 
kubectl get pods
kubectl get services

echo -e "\nПроверка... Дожидаемся, пока pod не будет запущен..." 
# Проверяем статус пода
while true; do
    # Получите имя Pod, связанного с вашим деплойментом
    POD_NAME=$(kubectl get pods -l app=$DEPLOYMENT_NAME -o jsonpath="{.items[0].metadata.name}")

    # Получите статус Pod
    STATUS=$(kubectl get pod "$POD_NAME" --no-headers | awk '{print $3}')
    if [ "$STATUS" = "Running" ]; then
        echo "Под $POD_NAME запущен и имеет статус Running."
        break
    else
        echo "Под $POD_NAME в статусе $STATUS. Повторная проверка через 2 секунды..."
        sleep 2
    fi
done

echo -e "\nСейчас откроется окно браузера!"
#kubectl exec -it "$POD_NAME" -- curl localhost:8000
minikube service "$SERVICE_NAME"

echo -e "\nНа этом выполнение скрипта $0 завершается!"