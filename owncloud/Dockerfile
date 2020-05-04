FROM owncloud/server:10.2.1

RUN apt-get update &&\
    apt-get install -y \
    lsb-release \
    sudo \
    wget \
    curl \
    telnet \
    less \
    patch \
    git \
    emacs \
    php7.2-xdebug \
    phpunit

RUN git clone --branch  release-1.5 https://github.com/stefan-wolfsheimer/irods-php.git \
    /var/www/lib/irods-php

# in live enviornments one can also install the apps to
# /var/www/owncloud/custom/
RUN git clone https://github.com/stefan-wolfsheimer/owncloud-files_irods.git \
    /var/www/owncloud/apps/files_irods

RUN git clone https://github.com/stefan-wolfsheimer/owncloud-irods_meta.git \
    /var/www/owncloud/apps/irods_meta

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs && \
    cd /var/www/owncloud/apps/irods_meta && \
    npm install && \
    ./node_modules/.bin/webpack-cli && \
    cd /

ADD owncloud/sleep.sh /sleep.sh
ADD owncloud/oc_setup.sh /oc_setup.sh
ADD owncloud/irods_environment.json /etc/irods/irods_environment.json

CMD ["owncloud", "server"]
