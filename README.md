*This project has been created as part of the 42 curriculum by miwehbe*

# Inception

## Description

Inception is a system administration project from 42. The goal is to build a small infrastructure using Docker, where each service runs in its own container. Everything runs inside a Virtual Machine.

The setup includes three containers: NGINX as the only entry point (HTTPS port 443, TLSv1.2/1.3), WordPress with php-fpm for the website, and MariaDB for the database. Two named volumes keep the data persistent, and a custom Docker network lets the containers talk to each other.

All images are built from scratch using custom Dockerfiles based on Debian.

## Instructions

### Requirements

- A Virtual Machine with Debian
- Docker and Docker Compose installed
- `make` installed

### How to run it

Clone the repo inside your VM:

```bash
git clone <your-repo-url>
cd inception
```

Create the data folders:

```bash
mkdir -p /home/miwehbe/data/wordpress
mkdir -p /home/miwehbe/data/mariadb
```

Add the domain to `/etc/hosts` so your browser can find the site:

```bash
echo "10.0.2.15 miwehbe.42.fr" | sudo tee -a /etc/hosts
```

Fill in `srcs/.env` with your values (domain name, database credentials, etc.), then run:

```bash
make
```

Open `https://miwehbe.42.fr` in your browser.

### Stop

```bash
make down
```

### Full clean

```bash
make clean
```

## Project Description

The project is split into three services, each with its own Dockerfile inside `srcs/requirements/`. Docker Compose ties everything together using `srcs/docker-compose.yml`. All configuration and credentials are stored in `srcs/.env`, which is git-ignored and never pushed to the repository.

NGINX is the only container exposed to the outside - everything else is internal. All containers restart automatically if they crash.

---

### Virtual Machines vs Docker

A VM is a full computer running inside your computer  it has its own OS, takes minutes to start, and uses a lot of RAM and disk. Docker is much lighter because containers share the host's kernel instead of running a full OS. You get the same isolation for services like a web server or database, but without all the overhead.

### Docker Network vs Host Network

With a custom Docker network, containers are isolated from the outside world and can only talk to each other through the network you define. They reach each other by service name, so WordPress just uses `mariadb` as the hostname to connect to the database. Host network skips all that and shares the host's network directly, which removes isolation and is forbidden in this project.

### Docker Volumes vs Bind Mounts

A bind mount directly links a folder from your host machine into a container. It works, but it's tied to a specific path on a specific machine. Named volumes are managed by Docker, more portable, and cleaner to use. This project uses named volumes for both the WordPress files and the MariaDB database, stored at `/home/miwehbe/data/` on the host.

---

## Resources

- [Docker docs](https://docs.docker.com/)
- [Docker Compose docs](https://docs.docker.com/compose/)
- [NGINX docs](https://nginx.org/en/docs/)
- [MariaDB docs](https://mariadb.com/kb/en/documentation/)
- [WordPress CLI](https://wp-cli.org/)
- [PHP-FPM config](https://www.php.net/manual/en/install.fpm.configuration.php)
- [OpenSSL self-signed certs](https://www.openssl.org/docs/)
- TechWorld with Nana : Docker full course (YouTube)

### AI Usage

I used AI mainly to double-check things I wasn't 100% sure about like volume paths, or Dockerfile syntax. I also used it when I was stuck on a problem and couldn't figure out where it was coming from. Either way, I always made sure I understood the answer before using it.
