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

Add existing [ssh keys](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) 
to your workspace configuration

```
cp ~/.ssh/id_rsa* config/workspace/custom/ssh
```

## Start Docker

```bash
docker-compose up
```

## Execute Commands

As root:

```bash
docker exec -it blog_workspace bash
```

As devsquad:

```bash
docker exec -u devsquad -it blog_workspace zsh
```

For simplicity, you can add this function to your `.bashrc` (or equivalent) 
and start a new **Zsh** session in the workspace container by running `docker_bash`.

```bash
function docker_bash() {
  export $(cat .env | xargs);
  docker exec -u devsquad -it ${APP_NAME}_workspace zsh;
}
```

## Code Setup

Make sure the workspace container is running and start a new **Zsh** session

```
docker exec -u devsquad -it blog_workspace zsh
``` 

Create a new project

```bash
cd ~; composer create-project --prefer-dist laravel/laravel blog
rm -Rf /var/www/* 
mv ~/blog/* /var/www
rm -Rf ~/blog
```

Clone an existing project

```bash
git clone git@github.com:teamdevsquad/laradoc.git /var/www
```

## Laravel setup

From the workspace container run

```bash
cd /var/www

composer install
yarn

cp .env.example .env
php artisan key:generate
php artisan storage:link
```

Access your application services

* Main - http://blog.test
* Adminer - http://adminer.blog.test:8080
* Maildev - http://maildev.blog.test:8181

## Git Flow Setup

From the workspace container run

```bash
cd /var/www

git flow init
```

Follow the instruction and aswer the following

* Branch name for production releases? **master**
* Branch name for "next release" development? **develop**
* Feature branches? [] **feature**
* Bugfix branches? [] **bugfix**
* Release branches? [] **release**
* Hotfix branches? [] **hotfix**
* Support branches? [] **support**
* Version tag prefix? []
* Hooks and filters directory? **/var/www/.git/hooks**

After that, you gitflow configuration (located in /var/www/.gitconfig) will be as follows

```
[gitflow "branch"]
	master = master
	develop = develop
[gitflow "prefix"]
	feature = feature/
	bugfix = bugfix/
	release = release/
	hotfix = hotfix/
	support = support/
[gitflow "path"]
	hooks = /var/www/.git/hooks
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

