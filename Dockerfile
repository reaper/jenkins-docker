FROM jenkins/jenkins:latest
USER root

RUN apt-get update
RUN apt-get install -y curl bison build-essential zlib1g-dev libssl-dev libreadline-dev procps
RUN apt-get install -y libmariadb-dev libxml2-dev git-core default-libmysqlclient-dev pkg-config libxslt1-dev
RUN apt-get install -y cifs-utils nodejs mariadb-client awscli openvpn vim rename sudo rsync duplicity gocryptfs fuse librsync-dev gettext python3-pip python3-b2sdk iputils-ping duplicity

RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/jenkins

# Install scalingo
RUN curl -O https://cli-dl.scalingo.io/install && bash install

USER jenkins

RUN curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
RUN curl -sSL https://get.rvm.io | bash

RUN ~/.rvm/bin/rvm get master --auto-dotfiles
RUN ~/.rvm/bin/rvm autolibs disable
RUN ~/.rvm/bin/rvm requirements
RUN ~/.rvm/bin/rvm install 2.7.4

RUN echo "rvm_install_on_use_flag=1" >> ~/.rvmrc
RUN echo "rvm_project_rvmrc=1" >> ~/.rvmrc
RUN echo "rvm_gemset_create_on_use_flag=1" >> ~/.rvmrc

RUN . $HOME/.rvm/environments/ruby-2.7.4 && gem update bundler
