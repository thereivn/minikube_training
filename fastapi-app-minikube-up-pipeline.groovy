pipeline{
    agent any
    environment{
        KUBECONFIG = '/home/thereiv/.kube/config'
    }

    stages{
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
    }
}