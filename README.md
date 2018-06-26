# DevSquad Laravel Docker

Docker configuration for Laravel Projects developed by DevSquad

## Setup

Customize the .env file

```bash
cp .env-example .env
```

Set the `DOCKER_HOST_IP` variable with your IP Address

```
ipconfig getifaddr en0
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

## Post Install

### Git Configuration

```bash
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
```
