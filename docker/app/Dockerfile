FROM php:fpm-alpine

WORKDIR /data

# Change user www-data UID and GID to: 1000
RUN deluser www-data \
    && addgroup -g 1000 -S www-data \
    && adduser -u 1000 -D -S -G www-data www-data

# Install PHP Dependencies: PDO MySQL
RUN docker-php-ext-install pdo_mysql

# Install Composer
RUN apk --update --no-progress add git \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer
