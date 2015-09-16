FROM ubuntu:14.04.3
MAINTAINER Timo Kuisma <timo.kuisma@iki.fi>

USER root

# Locale settings
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
ENV LOCALE en_US.UTF-8

# Updates
RUN apt-get update
RUN apt-get upgrade -y

# Initial install packages
RUN apt-get install -y apache2 curl git wget supervisor openssh-server

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update

# Install PostgreSQL
ENV PG_MAJOR 9.4

RUN apt-get install -y postgresql-common postgresql-$PG_MAJOR postgresql-contrib-$PG_MAJOR libpq-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data


# Setup deployment user
RUN useradd -m -s /bin/bash -K UID_MIN=10000 -K GID_MIN=10000 deploy
RUN echo 'deploy:testaaja' | chpasswd
RUN adduser deploy sudo
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


# Run following commands as the ``postgres`` user
USER postgres

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.

RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE ROLE rad_rails WITH createdb login PASSWORD 'mypass';"

# Adjust PostgreSQL configuration so that remote connections to the database are possible.
RUN echo "host    all             all             0.0.0.0/0               md5" >> /etc/postgresql/$PG_MAJOR/main/pg_hba.conf

# And add ``listen_addresses``
RUN echo "listen_addresses='*'" >> /etc/postgresql/$PG_MAJOR/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

USER root

# RVM && Ruby
ENV RUBY_VERSION ruby-2.1.5
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c 'source /etc/profile.d/rvm.sh'
RUN /bin/bash -l -c 'rvm requirements'
RUN /bin/bash -l -c 'rvm install $RUBY_VERSION'
RUN /bin/bash -l -c 'rvm use $RUBY_VERSION --default'
RUN /bin/bash -l -c 'gem install bundler --no-ri --no-rdoc'
RUN /bin/bash -l -c 'rvm gemset create rails-demo'
RUN /bin/bash -l -c 'rvm use $RUBY_VERSION@rails-demo --default'

USER deploy

# Clone project from GitHub

WORKDIR $HOMEDIR
ENV HOME $HOMEDIR
ENV NYT_BEST_SELLER_API_KEY 8d406380c2a31d4b3cf521239e11d989:14:69794481

RUN /bin/bash -l -c 'git clone git@github.com:tkuisma/rails-app-demo.git rails-app-demo'

USER root
RUN /bin/bash
RUN /etc/profile.d/rvm.sh
WORKDIR $HOMEDIR/rails-app-demo
RUN /bin/bash -l -c 'bundle install'

USER deploy
RUN /bin/bash -l -c 'source /etc/profile.d/rvm.sh'
WORKDIR $HOMEDIR/rails-app-demo
# RUN /bin/bash -l -c 'rake db:create'
# RUN /bin/bash -l -c 'rake db:migrate'

# start Supervisor

USER root
EXPOSE 22 80 8080
CMD ["/usr/bin/supervisord"]
