pipeline{
	agent any
	
	options{
	buildDiscarder(logRotator(numToKeepStr:"2"))
	}
	stages{
		stage("SCM"){
			steps{
				git branch: 'main', url: 'https://github.com/chaan2835/my-yankils-helloworld.git'
			}
		}
		stage("maven-Build"){
			steps{
				sh "mvn test"
				sh "mvn verify -DskipunitTests"
				sh "mvn clean install"
			}
		}
		stage("sonar code analysis"){
			steps{
				script{
						withSonarQubeEnv(credentialsId: 'sonar-token') {
   						 sh "mvn clean package sonar:sonar"
						}
					}

				}
			}
		stage("sonar quality check"){
			steps{
				script{
					waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
					}
				}
			}
		stage("Docker-login"){
			steps{
				sh "docker login -u chaan2835 -pChandra@2835"
			}
		}
		stage("Docker-Build"){
			steps{
				sh "docker build -t chaan2835/my-yankils-helloworld ."
			}
		}
	}
}
