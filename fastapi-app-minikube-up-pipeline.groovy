pipeline{
    agent any
    enviroment{
        KUBECONFIG = '/home/thereiv/.kube/config'
    }

    stages{
        stage('Start minikube'){
            steps{
                script{
                    sh 'minikube start'
                }
            }
        }
        stage('Deploy fastapi app'){
            steps{
                script{
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
        stage('Check pods and services'){
            steps{
                script{
                    sh 'kubectl get pods'
                    sh 'kubectl get services'
                }
            }
        }
        stage('Check Fastapi app'){
            steps{
                script{
                    def serviceName = 'reivn-fastapi-service'
                    def minikubeIp = sh(script: "minikube ip")
                    def port = sh(script: "kubectl get svc ${serviceName} -o jsonpath='{.spec.ports[0].port}'", returnStdout: true).trim()
                    sh "curl -I ${minikubeIp}:${port}"
                }
            }
        }
    }
}