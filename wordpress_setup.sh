#!/usr/bin/env bash

set -e

read -p "Enter WordPress database name [wordpress]: " DB_NAME
DB_NAME=${DB_NAME:-wordpress}

read -p "Enter WordPress database user [wordpressuser]: " DB_USER
DB_USER=${DB_USER:-wordpressuser}

read -s -p "Enter WordPress database password: " DB_PASSWORD
echo

WP_DIR="/tmp/wordpress"
WEB_ROOT="/var/www/html"

sudo apt update && sudo apt full-upgrade -y
sudo apt install -y apache2 mysql-server php libapache2-mod-php php-mysql rsync curl tar
sudo systemctl restart apache2

sudo mysql <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
EOF

cd /tmp
curl -LO https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz

cp ${WP_DIR}/wp-config-sample.php ${WP_DIR}/wp-config.php
sed -i "s/database_name_here/${DB_NAME}/" ${WP_DIR}/wp-config.php
sed -i "s/username_here/${DB_USER}/" ${WP_DIR}/wp-config.php
sed -i "s/password_here/${DB_PASSWORD}/" ${WP_DIR}/wp-config.php

sudo rsync -avP ${WP_DIR}/ ${WEB_ROOT}/
sudo chown -R www-data:www-data ${WEB_ROOT}/
sudo chmod -R 755 ${WEB_ROOT}/
sudo rm -f ${WEB_ROOT}/index.html
sudo systemctl restart apache2

SERVER_IP=$(hostname -I | awk '{print $1}')
echo "Open: http://${SERVER_IP}"
