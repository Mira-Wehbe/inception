# Developer Documentation

## Setup

First make sure you have Docker, Docker Compose, make, and git installed inside your Debian VM.

Clone the repo and enter the folder. Then add the domain to `/etc/hosts`:

```bash
echo "10.0.2.15 miwehbe.42.fr" | sudo tee -a /etc/hosts
```

Create `srcs/.env` manually ,it's git-ignored so it won't be in the repo. Fill it with these variables:

```
DOMAIN_NAME=miwehbe.42.fr
MYSQL_DATABASE=your_database_name
MYSQL_USER=your_db_user
MYSQL_PASSWORD=your_db_password
MYSQL_ROOT_PASSWORD=your_root_password
WP_ADMIN_USER=your_admin_username
WP_ADMIN_PASSWORD=your_admin_password
WP_ADMIN_EMAIL=your_admin_email
WP_USER=your_second_user
WP_USER_PASSWORD=your_second_user_password
WP_USER_EMAIL=your_second_user_email
```

One important thing `WP_ADMIN_USER` cannot contain the word `admin` in any form.

## Running the project

To build and start everything:

```bash
make
```

This creates the data folders, builds the images and starts the containers. After that just open `https://miwehbe.42.fr` in your browser.

To start containers that are already built:

```bash
make up
```

To stop without removing anything:

```bash
make stop
```

To stop and remove containers:

```bash
make down
```

To also remove volumes (you'll lose all data):

```bash
make clean
```

To wipe everything and start fresh:

```bash
make fclean
make re
```

## Useful commands

Check what's running:

```bash
docker compose -f ./srcs/docker-compose.yml ps
```

See logs:

```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```

Get inside a container:

```bash
docker exec -it mariadb bash
docker exec -it wordpress bash
docker exec -it nginx bash
```

Check your volumes:

```bash
docker volume ls
docker volume inspect <volume-name>
```

## Data and persistence

WordPress files and the database are stored on the host at `/home/miwehbe/data/`. This means data survives restarts and reboots. The only way to lose it is by running `make fclean`, which deletes everything including those folders.
