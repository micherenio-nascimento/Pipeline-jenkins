FROM tomcat:9.0

WORKDIR /usr/local/tomcat

RUN curl -L -o /usr/local/tomcat/webapps/jenkins.war https://get.jenkins.io/war-stable/latest/jenkins.war

USER root
RUN apt-get update && apt-get install -y git maven

EXPOSE 8080

CMD ["catalina.sh", "run"]