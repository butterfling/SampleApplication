FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    docker.io

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"

RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

RUN groupadd -f docker && \
    usermod -aG docker jenkins && \
    newgrp docker

RUN chmod 666 /var/run/docker.sock || true

RUN mkdir -p /var/jenkins_home/caches && \
    chown -R jenkins:jenkins /var/jenkins_home && \
    chmod -R 777 /var/jenkins_home

EXPOSE 8080
EXPOSE 50000

VOLUME /var/jenkins_home

USER jenkins
