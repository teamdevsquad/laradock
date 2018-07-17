- [Getting Started](#getting-started)
  - [Project Configuration](#project-configuration)
  - [Developer Configuration](#developer-configuration)
    - [The .env file](#the-.env-file)
    - [The .ssh folder](#the-.ssh-folder)
    - [The .aliases file](#the-.aliases-file)
    - [The crontab file](#the-crontab-file)

## Getting Started

>:boom: 
> Out of the box, this configuration requires Docker Engine `17.09.0+` which offers support to the 
>**3.4 compose file format**.
> 

```bash
curl -fsSL https://raw.githubusercontent.com/teamdevsquad/laradock/master/install.sh -o ./install.sh \
  && bash ./install.sh \
  && rm ./install.sh
```

Start by copying the `docker` folder and the `docker-compose.yml` file into your project.

```bash
cp -R docker /project/path
cp docker-compose.yml /project/path/docker-compose.yml
```

### Project Configuration

Modify the following file:

 * `./docker-compose.yml`

For most of the projects, all the modification in the `docker-compose.yml` file will occur in this section:

```yml
x-variables:
  # Versions
  - &php-version PHP_VERSION=7.2
  - &node-version NODE_VERSION=9.11.2
  - &yarn-version YARN_VERSION=latest
  - &chrome-driver-version CHROME_DRIVER_VERSION=2.32

  # Container names
  - &nginx blog_nginx
  - &php-fpm blog_php-fpm
  - &adminer blog_adminer
  - &postgres blog_postgres
  - &workspace blog_workspace
  - &php-worker blog_php-worker

  # Domains
  - &domain-default DOMAIN_DEFAULT=blog.vcap.me
  - &domain-adminer DOMAIN_ADMINER=adminer.vcap.me

  # Database
  - &db-name POSTGRES_DB=devsquad
  - &db-username POSTGRES_USER=devsquad
  - &db-password POSTGRES_PASSWORD=secret

  # Misc
  - &box-name BOX_NAME=docker blog
```

The snippet above is a sample configuration for a project called `blog`.

## Developer Configuration

> :bulb:
> Configuration on this section might vary on every environment and are **absolutely optional**.
>

Modification will target following folders/files:

* `./.env`
* `./docker/data/.ssh`
* `./docker/config/workspace/.aliases`
* `./docker/config/workspace/crontab`

### The .env file

The `.env` file indicates the environment variables that you can use to modify some of 
the default values used to create the containers. See the `.env.example`.

These are the default configuration values:

```bash
ADMINER_PORT=8000
HTTP_PORT=80
HTTPS_PORT=443
POSTGRES_PORT=5433
XDEBUG_PORT=9000
YOUR_IP_ADDRESS=172.16.0.100
```
 
> :bulb: 
> Consider creating a `IP Alias` for your network interface. This way, you **won't** need to change you configuration 
> on different networks (ie. when working from home). For mac users `sudo ifconfig en0 alias 172.16.0.100 255.255.255.0`.

### The .ssh folder

Place your own .ssh configuration into this folder (ie. `config`, `id_rsa`, and `id_rsa.pub`).

### The .aliases file

This file will create useful aliases to be used once logged into the container. See `.aliases.example` for
an example configuration.

### The crontab file

This file can be used to setup cron jobs (ie. `php /var/www/artisan schedule:run`). 
