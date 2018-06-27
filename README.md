# DevSquad Laravel Docker

Docker configuration for Laravel Projects developed by DevSquad

## Getting Started

Clone the repository

```bash
git clone https://github.com/teamdevsquad/laravel-docker.git blog
```

Customize the .env file

```bash
cp .env-example .env
```

Customize the bashrc_aliases.sh file

```
cd config/workspace/custom; cp bashrc_aliases.sh.example bashrc_aliases.sh; cd -
```

Add existing ssh keys to your configuration

```
cp ~/.ssh/id_rsa* config/workspace/custom/ssh
```

## Start Docker

```bash
docker-compose up
```

## Login

As root:

```bash
docker exec -it blog_workspace bash
```

As devsquad:

```bash
docker exec -u devsquad -it blog_workspace zsh
```

For simplicity, you can add this function to your `.bashrc` (or equivalent) 
and login into docker by running `docker_login`

```bash
function docker_login() {
  export $(cat .env | xargs);
  docker exec -u devsquad -it ${APP_NAME}_workspace zsh;
}
```

## Project Setup

Create a new project

```bash
cd ~; composer create-project --prefer-dist laravel/laravel blog
rm -Rf /var/www/* 
mv ~/blog/* /var/www
rm -Rf ~/blog
```

Clone an existing project

```bash
cd ~; git clone git@github.com:teamdevsquad/laradoc.git /var/www
```

## Docker

List all containers (only IDs)
```bash
docker ps -aq
```

Stop all running containers

```bash
docker stop $(docker ps -aq)
```

Remove all containers

```bash
docker rm $(docker ps -aq)
```

Remove all images

```bash
docker rmi -f $(docker images -q)
```

