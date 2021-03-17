pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'pwd'
                sh 'mvn validate'
                sh 'mvn compile'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh 'mvn deploy'
            }
        }
                 stage('Publish') {
            steps {
                echo 'Publishing....'
                sh 'scp /home/centos/project/target/*.war /home/centos/apache-tomcat-7.0.94/webapps '
            }
        }
    }
}
