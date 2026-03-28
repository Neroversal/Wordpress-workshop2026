#!/usr/bin/env bash

set -e

# =========================
# Variables
# =========================
DB_NAME="wordpress"
DB_USER="wordpressuser"
DB_PASSWORD="password"
WP_DIR="/tmp/wordpress"
WEB_ROOT="/var/www/html"

echo "Updating system..."
sudo apt update && sudo apt full-upgrade -y

echo "Installing required packages..."
sudo apt install -y ssh apache2 mysql-server php libapache2-mod-php php-mysql rsync curl tar

echo "Restarting Apache..."
sudo systemctl restart apache2

echo "Creating WordPress database and user..."
sudo mysql <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
EOF

echo "Downloading WordPress..."
cd /tmp
curl -LO https://wordpress.org/latest.tar.gz

echo "Extracting WordPress..."
tar xzvf latest.tar.gz

echo "Preparing wp-config.php..."
cp ${WP_DIR}/wp-config-sample.php ${WP_DIR}/wp-config.php

sed -i "s/database_name_here/${DB_NAME}/" ${WP_DIR}/wp-config.php
sed -i "s/username_here/${DB_USER}/" ${WP_DIR}/wp-config.php
sed -i "s/password_here/${DB_PASSWORD}/" ${WP_DIR}/wp-config.php

echo "Copying WordPress files to web root..."
sudo rsync -avP ${WP_DIR}/ ${WEB_ROOT}/

echo "Setting ownership and permissions..."
sudo chown -R www-data:www-data ${WEB_ROOT}/
sudo chmod -R 755 ${WEB_ROOT}/

echo "Removing default Apache index page if present..."
sudo rm -f ${WEB_ROOT}/index.html

echo "Restarting Apache..."
sudo systemctl restart apache2

SERVER_IP=$(hostname -I | awk '{print $1}')

echo "========================================="
echo "WordPress files deployed successfully."
echo "Now open your browser and go to:"
echo "http://${SERVER_IP}"
echo "Complete the WordPress setup form there."
echo "========================================="
