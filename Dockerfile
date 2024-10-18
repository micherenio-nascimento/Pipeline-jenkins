FROM tomcat:9.0

WORKDIR /usr/local/tomcat

RUN curl -L -o /usr/local/tomcat/webapps/jenkins.war https://get.jenkins.io/war-stable/latest/jenkins.war

USER root
RUN apt-get update && \
    apt-get install -y git curl && \
    apt-get install -y apt-transport-https ca-certificates gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    groupadd docker && \
    useradd -m -s /bin/bash tomcat && \
    usermod -aG docker tomcat

EXPOSE 8080

VOLUME ["/var/run/docker.sock"]

CMD ["catalina.sh", "run"]