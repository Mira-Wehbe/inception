# User Documentation

## What this project provides

This stack runs a WordPress website with three services:

- **NGINX** : handles all incoming traffic, HTTPS only on port 443
- **WordPress + php-fpm** : the actual website and its content
- **MariaDB** : the database that stores everything WordPress needs

The only way to reach the site is through `https://miwehbe.42.fr`. There is no HTTP access.

---

## Starting and stopping the project

Build and start everything from scratch:

```bash
make
```

This creates the data folders, builds the images, and starts all containers in the background.

Start already-built containers:

```bash
make up
```

Stop containers without removing anything:

```bash
make stop
```

Stop and remove containers:

```bash
make down
```

Remove containers and volumes (data will be lost):

```bash
make clean
```

Full reset removes everything including images and data folders:

```bash
make fclean
```

Rebuild everything from zero:

```bash
make re
```

---

## Accessing the website

Open your browser and go to:

```
https://miwehbe.42.fr
```

You will see a self-signed certificate warning — this is expected, just accept it and continue.

To access the WordPress administration panel:

```
https://miwehbe.42.fr/wp-admin
```

Log in with the admin account credentials stored in `srcs/.env`.

---

## Credentials

All credentials are stored in `srcs/.env`. This file is git-ignored and stays only on your machine. Open it to find:

- WordPress admin username and password
- WordPress regular user username and password
- MariaDB database name, user, and password

---

## Checking that everything is running

List all running containers:

```bash
docker compose -f ./srcs/docker-compose.yml ps
```

All three containers (nginx, wordpress, mariadb) should show as running.

Check the logs of a specific container if something looks wrong:

```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```

Check that your volumes exist and point to the right place:

```bash
docker volume ls
docker volume inspect <volume-name>
```

The path in the output should contain `/home/miwehbe/data/`.
