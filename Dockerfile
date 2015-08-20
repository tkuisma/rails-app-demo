FROM ubuntu:14.04.3
MAINTAINER Timo Kuisma <timo.kuisma@iki.fi>

USER root

# Update 
RUN apt-get update
RUN apt-get upgrade -y

# Apache && curl && git
RUN apt-get install -y apache2 curl git

# RVM && Ruby
ENV RUBY_VERSION 2.1.5
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c 'source /etc/profile.d/rvm.sh'

RUN /bin/bash -l -c 'rvm requirements'
RUN /bin/bash -l -c 'rvm install $RUBY_VERSION'
RUN /bin/bash -l -c 'rvm use $RUBY_VERSION --default'
RUN /bin/bash -l -c 'rvm gemset create rails-demo'
RUN /bin/bash -l -c 'rvm use $RUBY_VERSION@rails-demo'

# Setup User
RUN useradd -m -s /bin/bash -K UID_MIN=10000 -K GID_MIN=10000 deploy
ENV HOMEDIR /home/deploy
RUN mkdir $HOMEDIR/.ssh
RUN chown deploy:deploy -R $HOMEDIR/.ssh
RUN chmod -R 700 $HOMEDIR/.ssh

# Add github key
RUN touch $HOMEDIR/.ssh/known_hosts
RUN ssh-keyscan github.com >> $HOMEDIR/.ssh/known_hosts

COPY containers/id_rsa $HOMEDIR/.ssh/
COPY containers/id_rsa.pub $HOMEDIR/.ssh/
RUN chown deploy:deploy $HOMEDIR/.ssh/*
RUN chmod 600 $HOMEDIR/.ssh/*

USER deploy

# Clone project from GitHub

WORKDIR $HOMEDIR
ENV HOME $HOMEDIR

RUN /bin/bash -l -c 'git clone git@github.com:tkuisma/rails-app-demo.git rails-app-demo'
