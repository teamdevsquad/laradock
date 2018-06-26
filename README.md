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
cd config/workspace/custom && cp bashrc_aliases.sh.example bashrc_aliases.sh
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

## Start Laravel

```bash
cd ~
composer create-project --prefer-dist laravel/laravel blog
rm -Rf /var/www/* 
mv ~/blog/* /var/www
rm -Rf ~/blog
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

