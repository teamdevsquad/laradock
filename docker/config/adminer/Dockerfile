FROM adminer:4.3.0

LABEL maintainer="Patrick Artounian <partounian@gmail.com>"

VOLUME /sessions

COPY ./index.php /var/www/html/index.php

USER root

ARG POSTGRES_DB=${POSTGRES_DB}
ARG POSTGRES_USER=${POSTGRES_USER}
ARG POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

ENV POSTGRES_DB ${POSTGRES_DB}
ENV POSTGRES_USER ${POSTGRES_USER}
ENV POSTGRES_PASSWORD ${POSTGRES_PASSWORD}

RUN sed -i "s/DATABASE/${POSTGRES_DB}/g" /var/www/html/index.php \
    && sed -i "s/USERNAME/${POSTGRES_USER}/g" /var/www/html/index.php \
    && sed -i "s/PASSWORD/${POSTGRES_PASSWORD}/g" /var/www/html/index.php

USER adminer

EXPOSE 8080
