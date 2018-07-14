ARG PHP_VERSION=${PHP_VERSION}

FROM laradock/workspace:2.2-${PHP_VERSION}

LABEL maintainer="Team DevSquad <team@devsquad.com>"

USER root

ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

RUN groupadd -g ${PGID} devsquad \
    && useradd -u ${PUID} -g devsquad -m devsquad -G docker_env \
    && usermod -aG sudo devsquad \
    && usermod -p "*" devsquad \
    && chown devsquad:devsquad -R /home/devsquad

###########################################################################
# Set Timezone
###########################################################################

ARG TZ=UTC
ENV TZ ${TZ}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

###########################################################################
# Utils
###########################################################################

USER root

RUN apt-get -y update \
    && apt-get -y install tree \
    && apt-get -y install iputils-ping

###########################################################################
# Oh My Zsh
###########################################################################

USER root

COPY ./box-name /root/.box-name

RUN apt-get -y update \
  && apt-get -y install zsh \
  && curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o /root/install.sh \
  && export ZSH=/root/.oh-my-zsh \
  && bash /root/install.sh \
  && rm /root/install.sh \
  && chsh -s /bin/zsh \
  && chsh -s /bin/zsh devsquad \
  && sed '/^#.*CASE_SENSITIVE.*/ s/^#//' /root/.zshrc

USER devsquad

COPY ./box-name /home/devsquad/.box-name

RUN curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o /home/devsquad/install.sh \
  && export ZSH=/home/devsquad/.oh-my-zsh \
  && bash /home/devsquad/install.sh \
  && rm /home/devsquad/install.sh \
  && curl -fsSL https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme -o /home/devsquad/.oh-my-zsh/custom/themes/honukai.zsh-theme \
  && sed '/^#.*CASE_SENSITIVE.*/ s/^#//' /home/devsquad/.zshrc \
  && sed -i 's/robbyrussell/honukai/g' /home/devsquad/.zshrc

USER root

ARG BOX_NAME=${BOX_NAME}
ENV BOX_NAME ${BOX_NAME}

RUN sed -i "s/BOX_NAME/${BOX_NAME}/g"  /root/.box-name \
    && sed -i "s/BOX_NAME/${BOX_NAME}/g"  /home/devsquad/.box-name \
    && cat /root/.box-name \
    && cat /home/devsquad/.box-name

###########################################################################
# User Aliases
###########################################################################

USER devsquad

RUN echo "" >> ~/.zshrc && \
    echo "# Load Custom Aliases" >> ~/.zshrc && \
    echo "if [ -f /home/devsquad/.aliases ]; then" >> ~/.zshrc && \
    echo "  . /home/devsquad/.aliases " >> ~/.zshrc && \
    echo "fi" >> ~/.zshrc && \
	echo "" >> ~/.zshrc

###########################################################################
# Composer:
###########################################################################

USER root

COPY ./composer.json /home/devsquad/.composer/composer.json

RUN chown -R devsquad:devsquad /home/devsquad/.composer

USER devsquad

ARG COMPOSER_GLOBAL_INSTALL=false
ENV COMPOSER_GLOBAL_INSTALL ${COMPOSER_GLOBAL_INSTALL}

RUN composer global install

RUN echo "" >> ~/.zshrc && \
    echo 'export PATH="~/.composer/vendor/bin:$PATH"' >> ~/.zshrc \
    echo 'export PATH="/var/www/vendor/bin:$PATH"' >> ~/.zshrc

###########################################################################
# Crontab
###########################################################################

USER root

COPY ./crontab /etc/cron.d/devsquad
RUN chmod -R 644 /etc/cron.d

###########################################################################
# xDebug:
###########################################################################

USER root

ARG PHP_VERSION=${PHP_VERSION}

RUN apt-get install -y --force-yes php${PHP_VERSION}-xdebug && \
    sed -i 's/^;//g' /etc/php/${PHP_VERSION}/cli/conf.d/20-xdebug.ini && \
    echo "alias phpunit='php -dzend_extension=xdebug.so /var/www/vendor/bin/phpunit'" >> ~/.zshrc

COPY ./xdebug.ini /etc/php/${PHP_VERSION}/cli/conf.d/xdebug.ini

###########################################################################
# PHP REDIS EXTENSION
###########################################################################

ARG PHP_VERSION=${PHP_VERSION}

RUN printf "\n" | pecl -q install -o -f redis && \
    echo "extension=redis.so" >> /etc/php/${PHP_VERSION}/mods-available/redis.ini && \
    phpenmod redis

###########################################################################
# Node / NVM:
###########################################################################

USER devsquad

# Check if NVM needs to be installed
ARG NODE_VERSION=stable
ENV NODE_VERSION ${NODE_VERSION}
ENV NVM_DIR /home/devsquad/.nvm

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash \
        && . $NVM_DIR/nvm.sh \
        && nvm install ${NODE_VERSION} \
        && nvm use ${NODE_VERSION} \
        && nvm alias ${NODE_VERSION}

RUN echo "" >> ~/.zshrc && \
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.zshrc

# Add NVM binaries to root's .zshrc
USER root

RUN echo "" >> ~/.zshrc && \
    echo 'export NVM_DIR="/home/devsquad/.nvm"' >> ~/.zshrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.zshrc

# Add PATH for node
ENV PATH $PATH:$NVM_DIR/versions/node/v${NODE_VERSION}/bin

###########################################################################
# YARN:
###########################################################################

USER devsquad

ARG INSTALL_YARN=true
ARG YARN_VERSION=latest
ENV YARN_VERSION ${YARN_VERSION}

RUN if [ ${YARN_VERSION} = "latest" ]; then \
        curl -o- -L https://yarnpkg.com/install.sh | bash; \
    else \
        curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version ${YARN_VERSION}; \
    fi && \
    echo "" >> ~/.zshrc && \
    echo 'export PATH="$HOME/.yarn/bin:$PATH"' >> ~/.zshrc

USER root

RUN echo "" >> ~/.zshrc && \
    echo 'export YARN_DIR="/home/devsquad/.yarn"' >> ~/.zshrc && \
    echo 'export PATH="$YARN_DIR/bin:$PATH"' >> ~/.zshrc

###########################################################################
# pgsql client
###########################################################################

USER root

RUN apt-get -y install postgresql-client

###########################################################################
# Dusk Dependencies:
###########################################################################

USER root

ARG CHROME_DRIVER_VERSION=stable
ENV CHROME_DRIVER_VERSION ${CHROME_DRIVER_VERSION}

RUN apt-get update \
  && apt-get -y install zip wget unzip xdg-utils \
    libxpm4 libxrender1 libgtk2.0-0 libnss3 libgconf-2-4 xvfb \
    gtk2-engines-pixbuf xfonts-cyrillic xfonts-100dpi xfonts-75dpi \
    xfonts-base xfonts-scalable x11-apps \
  && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  && dpkg -i --force-depends google-chrome-stable_current_amd64.deb \
  && apt-get -y -f install \
  && dpkg -i --force-depends google-chrome-stable_current_amd64.deb \
  && rm google-chrome-stable_current_amd64.deb \
  && wget https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip \
  && unzip chromedriver_linux64.zip \
  && mv chromedriver /usr/local/bin/ \
  && rm chromedriver_linux64.zip

###########################################################################
# PYTHON:
###########################################################################

USER root

RUN apt-get -y install python python-pip python-dev build-essential  \
  && python -m pip install --upgrade pip  \
  && python -m pip install --upgrade virtualenv

###########################################################################
# HEROKU CLI
###########################################################################

USER root

RUN curl -fsSL https://cli-assets.heroku.com/install.sh -o /root/install.sh \
         && bash /root/install.sh \
         && rm /root/install.sh

###########################################################################
# Git Configuration:
###########################################################################

USER devsquad

RUN git config --global push.default simple \
    && git config --global core.editor "vim" \
    && echo "" >> ~/.gitignore_global \
    && echo ".vscode" >> ~/.gitignore_global \
    && echo ".idea" >> ~/.gitignore_global \
    && echo ".DS_STORE" >> ~/.gitignore_global \
    && git config --global core.excludesfile ~/.gitignore_global

###########################################################################
# Required Modules
###########################################################################

USER root

RUN apt-get -y update \
    && apt-get -y install php7.2-soap

###########################################################################
# Database client
###########################################################################

USER root

RUN apt-get update -yqq \
	&& apt-get -y install mysql-client \
	&& apt-get -y install postgresql-client

###########################################################################
# Check PHP version:
###########################################################################

ARG PHP_VERSION=${PHP_VERSION}

RUN php -v | head -n 1 | grep -q "PHP ${PHP_VERSION}."

###########################################################################
# Final Touch
###########################################################################

USER devsquad

RUN mkdir /home/devsquad/history \
    && touch /home/devsquad/history/.bash_history \
    && echo "# Change history location" >> ~/.zshrc \
    && echo "export HISTFILE=/home/devsquad/history/.bash_history " >> ~/.zshrc

USER root

WORKDIR /var/www

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog
