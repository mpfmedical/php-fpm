FROM php:5.6-fpm

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    SSMTP_AUTH_METHOD=LOGIN \
    SSMTP_USE_TLS=YES \
    SSMTP_USE_STARTTLS=YES

WORKDIR /var/www

RUN apt-get update && apt-get -y install libmcrypt-dev curl git zlib1g-dev libmemcached-dev libfreetype6-dev libjpeg62-turbo-dev libpng12-dev ssmtp mysql-client && rm -rf /var/lib/apt/lists/*;
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install pdo_mysql mysql bcmath mcrypt zip gd && pecl install memcached -f && docker-php-ext-enable memcached
RUN rm -rf /var/www && mkdir -p /var/www && chown -R www-data:www-data /var/www

COPY docker/entrypoint.sh /entrypoint.sh
COPY docker/php.ini /usr/local/etc/php/php.ini
COPY docker/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY docker/ssmtp.conf.template /etc/ssmtp/ssmtp.conf.template

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]
