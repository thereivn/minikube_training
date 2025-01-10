# Запуск в Minikube

Этот проект предоставляет скрипты для автоматизации запуска разных образов, к примеру Nginx сервера, в Minikube с использованием Kubernetes. В данном случае существуют скрипты, один из них проверяет состояние Minikube, применяет конфигурацию из манифест-файла для пода и сервиса под Nginx, а также управляет ресурсами. Второй позволяет быстро удалять под и сервис.

## Требования

- [Minikube](https://minikube.sigs.k8s.io/docs/start/) установлен и настроен.
- [kubectl](https://kubernetes.io/docs/tasks/tools/) установлен.
- Файлы конфигурации для пода и сервиса Nginx (`nginx-pod.yaml` и `nginx-service.yaml`).
- (По желанию) Наличие скриптов для быстрого взаимодействия с minikube.