#!/bin/bash
set -e

WP_PATH="/var/www/html"

# Wait for MariaDB
echo "Waiting for MariaDB "
until mysqladmin ping -h "mariadb" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
    echo "MariaDB is sleeping :)"
    sleep 2
done
echo "MariaDB is ready!"
sleep 3
# Copy WordPress files 
if [ ! -f "$WP_PATH/index.php" ]; then
    echo "Copying WordPress files:)"
    cp -r /usr/src/wordpress/* "$WP_PATH"
    chown -R www-data:www-data "$WP_PATH"
fi

cd "$WP_PATH"

#create wp-config.php ize mane mwjude
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="mariadb" \
        --allow-root
fi

#install wordp ize not exist
if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="Inception WordPress" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root
fi

#create new user ize msh mwjud
if ! wp user get "${WP_USER}" --allow-root >/dev/null 2>&1; then
    echo "Creating second WordPress user..."
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role=subscriber \
        --allow-root
fi
#beginnnnn
echo "Starting php-fpm "
exec php-fpm8.2 -F
