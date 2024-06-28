FROM php:8.3-alpine

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN apk add --no-cache linux-headers autoconf openssl-dev g++ make pcre-dev icu-dev zlib-dev libzip-dev && \
    docker-php-ext-install bcmath intl opcache zip sockets && \
    apk del --purge autoconf g++ make

WORKDIR /usr/src/app

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY composer.json composer.lock ./ ./

RUN composer install

RUN ./vendor/bin/rr get-binary --location /usr/local/bin

ENV APP_ENV=dev

RUN composer dump-autoload --optimize && \
    composer check-platform-reqs && \
    php bin/console cache:warmup

EXPOSE 8080