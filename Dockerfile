FROM jenkins/jenkins:latest
USER root

RUN apt-get update
RUN apt-get install -y curl bison build-essential zlib1g-dev libssl-dev libreadline-dev libxml2-dev git-core
RUN apt-get install -y awscli

# Install scalingo
RUN curl -O https://cli-dl.scalingo.io/install && bash install

USER jenkins

RUN curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
RUN curl -sSL https://get.rvm.io | bash

RUN ~/.rvm/bin/rvm get master --auto-dotfiles
RUN ~/.rvm/bin/rvm autolibs disable
RUN ~/.rvm/bin/rvm requirements
RUN ~/.rvm/bin/rvm install 3.0.0

RUN echo "rvm_install_on_use_flag=1" >> ~/.rvmrc
RUN echo "rvm_project_rvmrc=1" >> ~/.rvmrc
RUN echo "rvm_gemset_create_on_use_flag=1" >> ~/.rvmrc

RUN ~/.rvm/bin/rvm use 3.0.0 --default
RUN gem update bundler
RUN bundle config build.nokogiri --use-system-libraries
