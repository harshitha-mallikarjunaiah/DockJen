pipeline {
    agent any

    tools{
        maven 'maven'
    }

    stages{
        stage('Check and remove container'){
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
        stage('Build package'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Create image'){
            steps{
                sh 'sudo docker build -t app /var/lib/jenkins/workspace/task/'
            }
        }
        stage('Assign tag'){
            steps{
                sh 'docker tag app harsh5900/newapp'
            }
        }
        stage('Push to dockerhub'){
            steps{
                sh 'echo "Harshitha@9500" | docker login -u "harsh5900" --password-stdin'
                sh 'docker push harsh5900/newapp'
            }
        }
        stage('Remove images'){
            steps{
                sh 'docker rmi -f $(docker images -q)'
            }
        }
        stage('Pull image from DockerHub'){
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