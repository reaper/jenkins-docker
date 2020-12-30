FROM jenkins/jenkins:latest
USER root

RUN apt-get update
RUN apt-get install -y ruby ruby-dev

USER jenkins
