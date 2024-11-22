pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'sample-application'
        DOCKER_TAG = 'latest'
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Clean workspace before building
                cleanWs()
                // Checkout code from GitHub
                git branch: 'main',
                    url: 'https://github.com/butterfling/SampleApplication.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    // Stop and remove existing container if it exists
                    sh '''
                        docker stop ${DOCKER_IMAGE} || true
                        docker rm ${DOCKER_IMAGE} || true
                    '''
                    
                    // Run the new container
                    docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").run("-d --name ${DOCKER_IMAGE} -p 8081:80")
                }
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
