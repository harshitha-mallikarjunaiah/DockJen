pipeline {
    agent any

    tools{
        maven 'maven'
    }

    stages{
        stage('Check if a container new exists and remove container'){
            steps{
                script{
                    def containerExists = sh(script: "docker ps -q -f name=new", returnStdout: true).trim()
                    if (containerExists) {
                    sh "docker stop new"
                    sh "docker rm new"
                    }
                }
            }
        }
        stage('Run Maven to compile and package the application'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Create image- Build a Docker image from project directory'){
            steps{
                sh 'sudo docker build -t app /var/lib/jenkins/workspace/task/'
            }
        }
        stage('Create a new tag'){
            steps{
                sh 'docker tag app harsh5900/newapp'
            }
        }
        stage('Push the image to dockerhub'){
            steps{
                sh 'echo "Harshitha@9500" | docker login -u "harsh5900" --password-stdin'
                sh 'docker push harsh5900/newapp'
            }
        }
        stage('Delete the local image '){
            steps{
                sh 'docker rmi -f $(docker images -q)'
            }
        }
        stage('Download image from DockerHub :latest'){
            steps{
                sh 'docker pull harsh5900/newapp'
            }
        }
        stage('Run a container'){
            steps{
                sh 'docker run -it -d --name new -p 8081:8080 harsh5900/newapp'
            }
        }
    }
    post {
        success {
            echo 'Deployment successful'
        }
        failure {
            sh 'docker rm -f new'
        }
        always{
            echo 'Deployed'
        }
    }

}
