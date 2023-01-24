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

		}
	}

