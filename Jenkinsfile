pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'sample-application'
        DOCKER_TAG = 'latest'
    }
    
    stages {
        stage('Checkout') {
            steps {
                cleanWs()
                
                git branch: 'main',
                    url: 'https://github.com/butterfling/SampleApplication.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh """
                    docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                """
            }
        }
        
        stage('Deploy') {
            steps {
                sh """
                    docker stop ${DOCKER_IMAGE} || true
                    docker rm ${DOCKER_IMAGE} || true
                    docker run -d --name ${DOCKER_IMAGE} -p 8081:80 ${DOCKER_IMAGE}:${DOCKER_TAG}
                """
            }
        }
    }
    
    post {
        failure {
            echo 'Pipeline failed! Check the logs for details.'
        }
        success {
            echo 'Pipeline succeeded! Application deployed successfully.'
        }
    }
}
