FROM nginx:alpine

LABEL maintainer="Mahmoud Zalt <mahmoud@zalt.me>"

COPY nginx.conf /etc/nginx/

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash \
    && adduser -D -H -u 1000 -s /bin/bash www-data

ARG PHP_UPSTREAM_CONTAINER=php-fpm
ARG PHP_UPSTREAM_PORT=9000

# Set upstream conf and remove the default conf
RUN echo "upstream php-upstream { server ${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}; }" > /etc/nginx/conf.d/upstream.conf \
    && rm /etc/nginx/conf.d/default.conf

###########################################################################
# SSL
###########################################################################

# install openssl
RUN apk add --no-cache openssl

# create a folder for the keys
RUN mkdir /etc/nginx/ssl 2> /dev/null

# generate the keys for your local domain
RUN openssl genrsa -out "/etc/nginx/ssl/docker.key" 2048 \
    && openssl req -new -key "/etc/nginx/ssl/docker.key" -out "/etc/nginx/ssl/docker.csr" -subj "/CN=docker/O=devsquad/C=UK" \
    && openssl x509 -req -days 365 -in "/etc/nginx/ssl/docker.csr" -signkey "/etc/nginx/ssl/docker.key" -out "/etc/nginx/ssl/docker.crt"


###########################################################################
# Domain names
###########################################################################

ARG DOMAIN_ADMINER=${DOMAIN_ADMINER}
ENV DOMAIN_ADMINER ${DOMAIN_ADMINER}

ARG DOMAIN_DEFAULT=${DOMAIN_DEFAULT}
ENV DOMAIN_DEFAULT ${DOMAIN_DEFAULT}

COPY ./sites/adminer.conf /etc/nginx/sites-available/
COPY ./sites/default.conf /etc/nginx/sites-available/

RUN sed -i "s/DOMAIN_ADMINER/${DOMAIN_ADMINER}/g"  /etc/nginx/sites-available/adminer.conf \
    && sed -i "s/DOMAIN_DEFAULT/${DOMAIN_DEFAULT}/g"  /etc/nginx/sites-available/default.conf \
    && cat /etc/nginx/sites-available/adminer.conf \
    && cat /etc/nginx/sites-available/default.conf

###########################################################################
# Final touch
###########################################################################

CMD ["nginx"]

EXPOSE 80 443
