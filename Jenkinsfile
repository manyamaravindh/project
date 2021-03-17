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
                sh 'pwd'
                sh 'ls'
            }
        }
               stage('Publish') {
            steps {
                echo 'Publishing....'
                sh 'pwd'
                sh 'cd /var/lib/jenkins/workspace/Validate'
                sh 'ls'
                sh 'scp /var/lib/jenkins/workspace/Validate/target/*.war /var/lib/jenkins/workspace/Validate/apache-tomcat-7.0.94/webapps'  
            }
               }
        
    }
}
