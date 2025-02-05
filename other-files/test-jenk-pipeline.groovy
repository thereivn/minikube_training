pipeline{
    agent any

    stages{
        stage('First stage'){
            steps{
                script{
                    sh 'echo "Hello world!"'
                }
            }
        }
    }
}