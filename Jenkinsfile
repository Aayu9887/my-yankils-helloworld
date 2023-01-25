pipeline{
	agent any
	environment{
		DOCKERHUB_CREDENTIALS = credentials('docker-token')
	}
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
		
		stage("Build docker image"){
			steps{
				sh "docker build -t chaan2835/my-yankils-hello-world:$BUILD_NUMBER ."
			}
		}
		stage("docker login"){
			steps{
				sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
				}
		}
		stage ("Docker Push"){
			steps{
				sh "docker push chaan2835/my-yankils-hello-world:$BUILD_NUMBER"
			}
		}
	
	}
	post{
		always{
			sh "docker logout"
		}
	}
}

