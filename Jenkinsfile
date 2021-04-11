pipeline {
    agent any

	stages{
		
		stage("installations"){
			steps{
				node('ansible-node') {
					sh 'sudo yum install git -y'
					sh '(cd /home/centos/ &&  git clone https://github.com/manyamaravindh/project.git) || (cd /home/centos/project &&  git pull --all)'
    					sh 'cd /home/centos/ && ansible-playbook -i ./project/hosts.ini ./project/installations-playbook.yml -v'
				}
			}
		}
		
		stage("performance test"){
			steps{
				//sh 'mvn  sonar:sonar    -Dsonar.host.url=http://3.236.59.14:9000    -Dsonar.login=267e8b5b981d9604b7999074b941d2416156348b'
				node('ansible-node') {
					sh 'rm -rf /home/centos/project'
					sh '(cd /home/centos/ && git clone https://github.com/manyamaravindh/project.git ) || (cd /home/centos/project && git pull --all )'
    					sh 'cd /home/centos/project/ && ansible-playbook -i ./project/hosts.ini ./project/performance-test-playbook.yml -v'
				}
			}
		}
		stage("build"){
			steps{
				node('ansible-node'){
					sh 'cd /home/centos/project/ && ansible-playbook -i ./project/hosts.ini ./project/build-playbook.yml -v'
				}
			}
		}
		stage("docker build"){
			steps{
				node('ansible-node'){
					sh '(docker stop calculatorContainer && docker rm calculatorContainer) || echo "container is notrunning" '
					sh 'cd /home/centos/project && docker build -t aravindhmanyam/calc .'
					sh 'docker run --name calculatorContainer -dt -p 8080:8080 aravindhmanyam/calc '
					sh 'echo "docker container running on port 8080" '
				}
			}
		}
		stage("docker-push"){
			steps{
				node('ansible-node'){
					sh 'ansible-playbook -i ./project/hosts.ini ./project/docker-push-playbook.yml -v' 
				}
			}
		}
		stage("deploy"){
			steps{
				node('ansible-node'){
					sh 'cp /home/centos/project/target/*.war /home/centos/apache-tomcat-7.0.94/webapps/'
				}
			}
		}
		
		stage("release"){
			steps{
				node('ansible-node'){
					sh 'cd /home/centos/project && ansible-playbook -i ./project/hosts.ini ./project/release-playbook.yml -v'
				}
			}
		}
		
		stage("kubernetes-setup"){
			steps{
				node('ansible-node'){
					sh 'cd /home/centos/ && ansible-playbook -i ./project/hosts.ini ./project/kuberenetes-kops-setup-playbook.yml -v'	
				}
			}
		}
		
		
		
	}
}
