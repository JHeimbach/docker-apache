FROM ubuntu:16.04

RUN apt-get update && apt-get install -y apache2 curl

WORKDIR /etc/apache2
RUN sed -i -e 's/#ServerRoot "\/etc\/apache2"/ServerRoot "\/etc\/apache2"/g' apache2.conf

RUN a2dissite 000-default && \
    a2enmod rewrite socache_shmcb ssl proxy proxy_fcgi


ARG APACHE_SITE_CONF=sites-enabled/site.conf
ARG APACHE_SITE_CONF_FILE=./conf.d/apache2.conf

ARG APACHE_CUSTOM_CONF=conf-enabled/custom.conf
ARG APACHE_CUSTOM_CONF_FILE=./conf.d/site.conf

COPY $APACHE_CUSTOM_CONF_FILE $APACHE_CUSTOM_CONF
COPY $APACHE_SITE_CONF_FILE $APACHE_SITE_CONF


ENV APACHE_LOCK_DIR=/var/lock/apache2 \
    APACHE_PID_FILE=/var/run/apache2.pid \
    APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2 \
    APACHE_SERVER_NAME=localhost \
    APACHE_SITE_ADMIN=webmaster@localhost \
    APACHE_SITE_NAME=$APACHE_SERVER_NAME \
    APACHE_SITE_ROOT=/var/www/html \
    APACHE_SITE_ALIASES=$APACHE_SITE_NAME \
    APACHE_CONF_SITE=$APACHE_SITE_CONF \
    APACHE_CONF_CUSTOM=$APACHE_CUSTOM_CONF \
    PHP_SERVER=php


CMD ["apachectl", "-d .", "-DFOREGROUND"]