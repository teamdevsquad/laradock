ARG PHP_VERSION=${PHP_VERSION}

FROM laradock/php-fpm:2.2-${PHP_VERSION}

LABEL maintainer="Mahmoud Zalt <mahmoud@zalt.me>"

# always run apt update when start and after add new source list, then clean up at end.
RUN apt-get update -yqq && \
    pecl channel-update pecl.php.net

###########################################################################
# pgsql
###########################################################################

USER root

RUN docker-php-ext-install pgsql

###########################################################################
# pgsql client
###########################################################################

USER root

RUN mkdir -p /usr/share/man/man1 && \
    mkdir -p /usr/share/man/man7 && \
    apt-get install -y postgresql-client

###########################################################################
# xDebug:
###########################################################################

USER root

RUN pecl install xdebug && \
  docker-php-ext-enable xdebug

COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

###########################################################################
# PHP REDIS EXTENSION
###########################################################################

USER root

RUN printf "\n" | pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

###########################################################################
# pcntl
###########################################################################

USER root

RUN docker-php-ext-install pcntl

###########################################################################
# Human Language and Character Encoding Support:
###########################################################################

USER root

RUN apt-get install -y zlib1g-dev libicu-dev g++ && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl

###########################################################################
# Required Modules
###########################################################################

USER root

RUN apt-get install -y libxml2-dev \
    && docker-php-ext-install soap

###########################################################################
# Check PHP version:
###########################################################################

ARG PHP_VERSION=${PHP_VERSION}

RUN php -v | head -n 1 | grep -q "PHP ${PHP_VERSION}."

#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

COPY ./laravel.ini /usr/local/etc/php/conf.d
COPY ./xlaravel.pool.conf /usr/local/etc/php-fpm.d/

USER root

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

RUN usermod -u 1000 www-data

WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9000
