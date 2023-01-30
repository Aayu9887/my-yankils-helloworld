FROM tomcat:8
COPY /root/.jenkins/workspace/jfrog-artifactory-sonar/webapp/target/*.war /usr/local/tomcat/webapps/
