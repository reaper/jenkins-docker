FROM jenkins
USER root

RUN apt-get update
RUN apt-get install -y ruby-dev

USER jenkins
