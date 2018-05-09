FROM phusion/baseimage:latest

MAINTAINER bruin

RUN DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

# Add the "PHP 7" ppa
RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ondrej/php

# Node
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

# Install "PHP Extentions", "libraries", "Software's"
RUN apt-get update && \
    apt-get install -y --allow-downgrades --allow-remove-essential \
        --allow-change-held-packages \
#        php7.1-cli \
#        php7.1-common \
#        php7.1-curl \
#        php7.1-json \
#        php7.1-xml \
#        php7.1-mbstring \
#        php7.1-mcrypt \
#        php7.1-mysql \
#        php7.1-pgsql \
#        php7.1-sqlite \
#        php7.1-sqlite3 \
#        php7.1-zip \
#        php7.1-bcmath \
#        php7.1-memcached \
#        php7.1-gd \
#        php7.1-dev \
        pkg-config \
        libcurl4-openssl-dev \
        libedit-dev \
        libssl-dev \
        libxml2-dev \
        xz-utils \
        libsqlite3-dev \
        sqlite3 \
        git \
        curl \
        vim \
        postgresql-client \
        nodejs \
    && apt-get clean \
    && rm -Rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install composer

#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
#        && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
#        && php composer-setup.php \
#        && mv composer.phar /usr/local/bin/composer \
#        && rm -Rf composer-setup.php

# Install yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

# gulp bower vue-cli webpack
RUN $HOME/.yarn/bin/yarn global add gulp-cli vue-cli webpack

# Set Timezone Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone

# Source the bash
RUN . ~/.bashrc
