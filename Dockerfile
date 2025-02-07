FROM debian:buster-slim

LABEL maintainer="buddyspencer@protonmail.com"

ENV SSH_PORT=8022 
ENV GIT_USER=git 
ENV MYSQL_PORT=3306
ENV PROTOCOL=http

EXPOSE 8022 80 443

RUN apt-get update -y && apt-get install -y wget lsb-release && \
    apt-get -y install mercurial subversion sudo apt-transport-https ca-certificates wget git \
    php php-mysql php-gd php-curl php-apcu php-cli php-json php-mbstring php-fpm php-zip php-pear \
    nginx supervisor procps python-pygments openssh-server && \
    ln -s /usr/lib/git-core/git-http-backend /usr/bin/git-http-backend

#downloading phorge
RUN mkdir -p /var/www/phorge/
RUN git clone https://we.phorge.it/source/arcanist.git /var/www/phorge/arcanist\
    && git clone https://we.phorge.it/source/phorge.git /var/www/phorge/phorge

#copy nginx config
COPY ./configs/nginx-ph.conf /etc/nginx/sites-available/phorge.conf
COPY ./configs/nginx.conf /etc/nginx/nginx.conf
RUN ln -s /etc/nginx/sites-available/phorge.conf /etc/nginx/sites-enabled/phorge.conf

#copy ssh key generation
COPY ./configs/regenerate-ssh-keys.sh /regenerate-ssh-keys.sh
#copy php config
COPY ./configs/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./configs/php.ini /etc/php/7.4/fpm/php.ini
COPY ./configs/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
RUN mkdir -p /run/php && chown www-data:www-data /run/php
#copy supervisord config
COPY ./configs/supervisord.conf /etc/supervisord.conf
COPY ./scripts/startup.sh /startup.sh
#copy startup script
RUN mkdir -p /var/repo/ && rm -rf /var/cache/apt
CMD [ "/startup.sh" ]
