FROM php:fpm-alpine

WORKDIR /data

# Change user www-data UID and GID to: 1000
RUN deluser www-data \
    && addgroup -g 1000 -S www-data \
    && adduser -u 1000 -D -S -G www-data www-data

# Config PHP
RUN curl https://raw.githubusercontent.com/php/php-src/master/php.ini-development --output /usr/local/etc/php/php.ini

# Install PHP Dependencies: PDO MySQL, pcntl
RUN docker-php-ext-install pdo_mysql pcntl

# Install ffmpeg fonts command dependencies
RUN apk --update --no-progress add wget unzip git
