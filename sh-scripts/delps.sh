#!/bin/bash

kubectl delete -f ./yaml-files/nginx-pod.yaml
kubectl delete -f ./yaml-files/nginx-service.yaml