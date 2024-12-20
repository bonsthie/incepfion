#!/bin/sh

cd /var/www/html 

#cli to config wordpress
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

./wp-cli.phar core download --allow-root
./wp-cli.phar config create --dbname=wordpress --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb --allow-root
./wp-cli.phar core install --url=babonnet.42.fr --title=incepfion --admin_user=$WP_USER --admin_password=$WP_PASS --admin_email=admin@admin.com --allow-root

exec "$@"
