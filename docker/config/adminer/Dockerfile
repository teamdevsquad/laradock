FROM adminer:4.3.0

LABEL maintainer="Patrick Artounian <partounian@gmail.com>"

VOLUME /sessions

COPY ./index.php /var/www/html/index.php

USER root

ARG POSTGRES_DB=${POSTGRES_DB}
ARG POSTGRES_USERNAME=${POSTGRES_USERNAME}
ARG POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

ENV POSTGRES_DB ${POSTGRES_DB}
ENV POSTGRES_USERNAME ${POSTGRES_USERNAME}
ENV POSTGRES_PASSWORD ${POSTGRES_PASSWORD}

RUN sed -i "s/DATABASE/${POSTGRES_DB}/g" /var/www/html/index.php \
    && sed -i "s/USERNAME/${POSTGRES_USERNAME}/g" /var/www/html/index.php \
    && sed -i "s/PASSWORD/${POSTGRES_PASSWORD}/g" /var/www/html/index.php

USER adminer

EXPOSE 8080
