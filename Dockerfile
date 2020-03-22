# From https://hub.docker.com/r/moodlehq/moodle-php-apache/dockerfile
FROM php:7.1-apache-buster

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install --no-install-recommends --yes \
    wget \
    libzip-dev \
    zip \
    zlib1g-dev \
    libicu-dev\
    libpng-dev \
    libjpeg-dev \
    libxslt-dev \
    libwebp-dev \
    libxpm-dev \
    libmagickwand-dev \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install zip \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli \
    && docker-php-ext-enable mysqli \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-install iconv \
    && docker-php-ext-install soap \
    && docker-php-ext-install opcache \
    && docker-php-ext-install xsl \
    && docker-php-ext-install xmlrpc \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-configure gd --with-gd --with-webp-dir --with-jpeg-dir \
    --with-zlib-dir --with-xpm-dir --with-freetype-dir \
    --enable-gd-native-ttf

RUN docker-php-ext-install gd \
&& echo 'apc.enable_cli = On' >> /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini

RUN apt-get clean \
&& apt-get autoclean \
&& rm -rf /var/lib/apt/lists/* \
&& rm -rf /tmp/* /var/cache/apk/*

RUN cd /var/www/ \
    && wget https://download.moodle.org/download.php/direct/stable38/moodle-latest-38.tgz \
    && tar -xvf moodle-latest-38.tgz \
    && mv /var/www/moodle/* /var/www/html/ \
    && rm -rf /var/www/moodle/ \
    && chown -R www-data:www-data /var/www/html \
    && rm moodle-latest-38.tgz \
    && mkdir /var/www/moodledata && chown www-data /var/www/moodledata && \
    mkdir /var/www/phpunitdata && chown www-data /var/www/phpunitdata && \
    mkdir /var/www/behatdata && chown www-data /var/www/behatdata && \
    mkdir /var/www/behatfaildumps && chown www-data /var/www/behatfaildumps

COPY admin-cron /etc/cron.d/admin-cron.job

WORKDIR /var/www/html/

CMD ["apache2-foreground"]