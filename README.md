# WordPress Workshop 2026

Building WordPress on Ubuntu with Apache, MySQL, and PHP.

---

## Overview

This workshop walks through setting up a WordPress server from scratch using:

- Ubuntu
- Apache2
- MySQL
- PHP
- WordPress

---

## Parking Lot Commands

## 1. Set up SSH

Update the machine and install SSH:

```bash
sudo apt update && sudo apt full-upgrade -y
sudo apt install ssh

sudo nano /etc/ssh/sshd_config
PasswordAuthentication yes
sudo service ssh restart



<img width="478" height="352" alt="Screenshot 2026-03-27 at 10 36 42 PM" src="https://github.com/user-attachments/assets/505ff43e-b3ce-4be5-815f-0e4dcfe21b1d" />

<img width="482" height="327" alt="Screenshot 2026-03-27 at 10 37 14 PM" src="https://github.com/user-attachments/assets/6addc415-6b18-40f0-b513-c41899ad63df" />


sudo apt update
sudo apt install apache2

sudo apt install mysql-server
sudo mysql_secure_installation

Recommended MySQL Secure Installation Answers
Set up Validate Password plugin: Y
Password strength: press Enter for low (for testing purposes)
Remove anonymous users: Y
Disallow root login remotely: Y
Remove test database and access to it: Y
Reload privilege tables now: Y

At the end, you should see:

All done!



<img width="867" height="410" alt="Screenshot 2026-03-27 at 10 49 26 PM" src="https://github.com/user-attachments/assets/22b4af68-71ec-4493-b604-2ce3ce8c30db" />

<img width="861" height="512" alt="Screenshot 2026-03-27 at 10 54 36 PM" src="https://github.com/user-attachments/assets/a6b7448d-2738-49f7-bf4f-20330d6530c9" />

sudo apt install php libapache2-mod-php php-mysql
sudo systemctl restart apache2

6. WordPress Integration and Database Setup

We will now:

Create a database
Create a user
Grant that user access to the database
MySQL Commands

Enter MySQL:

sudo mysql

CREATE DATABASE wordpress;
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';
FLUSH PRIVILEGES;
exit

\q





# Wordpress-workshop2026
building wordpress 


###ParkingLot Commands 

1. setup ssh 

sudo apt update && sudo apt full-upgrade -y
sudo apt install ssh 
nano /etc/ssh/sshd_config
##PasswordAuthentication yes
sudo service ssh restart 

##SSH Server login 

<img width="478" height="352" alt="Screenshot 2026-03-27 at 10 36 42 PM" src="https://github.com/user-attachments/assets/505ff43e-b3ce-4be5-815f-0e4dcfe21b1d" />

<img width="482" height="327" alt="Screenshot 2026-03-27 at 10 37 14 PM" src="https://github.com/user-attachments/assets/6addc415-6b18-40f0-b513-c41899ad63df" />

2. update machine
sudo apt update 

3. Install apache2
sudo apt install apache2

4.MySQL
sudo apt install mysql-server
sudo mysql_secure_installation

## Y for setup Validate PW
## press enter ) low for testing purpose 
## remove anaymous users y
## disallow root login remotely y
## remove test database and access y
## reload privilege tabes now Y
## All done!

<img width="867" height="410" alt="Screenshot 2026-03-27 at 10 49 26 PM" src="https://github.com/user-attachments/assets/22b4af68-71ec-4493-b604-2ce3ce8c30db" />

<img width="861" height="512" alt="Screenshot 2026-03-27 at 10 54 36 PM" src="https://github.com/user-attachments/assets/a6b7448d-2738-49f7-bf4f-20330d6530c9" />

5. php install
sudo apt install php libapache2-mod-php php-mysql
sudo systemctl restart apache2  

6. WordPRess intergration and database 
## Create data base
## Create user
## give user access to database 

command####

- sudo mysql
- CREATE DATABASE wordpress;
- CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
- GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';
- FLUSH PRIVILEGES;
- exit or \q

 <img width="837" height="437" alt="Screenshot 2026-03-27 at 11 08 17 PM" src="https://github.com/user-attachments/assets/7b209139-7494-4945-808e-c8287ad6ba97" />

<img width="851" height="450" alt="Screenshot 2026-03-27 at 11 10 29 PM" src="https://github.com/user-attachments/assets/e60e0a81-7731-4be0-aefb-a700f98ef0ad" />


#### word press to /tmp folder 

cd /tmp 
curl -LO https://wordpress.org/latest.tar.gz
tar -tzf latest.tar.gz | head
tar xzvf latest.tar.gz

#### Gain access to word press ###

cd wordpress
- look for wp-config-sample.php
- <img width="857" height="153" alt="Screenshot 2026-03-27 at 11 21 07 PM" src="https://github.com/user-attachments/assets/ec86ed93-03df-4b95-b79c-e909494e9523" />

- cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
<img width="854" height="170" alt="Screenshot 2026-03-27 at 11 23 57 PM" src="https://github.com/user-attachments/assets/32530736-995f-4ced-a343-23e1a20d9f51" />


- nano wp-config.php
#### this is where we will configure our database 

define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'wordpressuser' );
define( 'DB_PASSWORD', 'password' );
define( 'DB_HOST', 'localhost' );

<img width="854" height="264" alt="Screenshot 2026-03-27 at 11 29 08 PM" src="https://github.com/user-attachments/assets/126c275d-5cab-4291-9ba3-80c2694fafb2" />

### lets copy our files fron this location and add to another location 
sudo rsync -avP /tmp/wordpress/ /var/www/html/
-a = archive mode, preserves structure and metadata
-v = verbose, shows what is happening
-P = shows progress and helps with partial transfers

#### move into our folder
cd /var/www/html 

###### make www the owner of this folder 
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

chmod changes permissions
-R means recursive, so it applies to all files and folders inside /var/www/html/
755 means:
owner = 7 = read, write, execute
group = 5 = read, execute
others = 5 = read, execute

<img width="834" height="149" alt="Screenshot 2026-03-27 at 11 38 10 PM" src="https://github.com/user-attachments/assets/bf5e1d3f-5c4e-4926-8e99-f28e530b4c73" />

#####apach2 default serverfile 
- nano index.html (we dont want this page... we want our wordpress page)
- sudo rm index.html
- let's visit our website using the ipaddress 
- take you 167.71.107.168 run it inside your url

<img width="313" height="372" alt="Screenshot 2026-03-27 at 11 43 52 PM" src="https://github.com/user-attachments/assets/dd7de2a1-2542-4dba-b3c9-d363ed399c98" />

<img width="433" height="430" alt="Screenshot 2026-03-27 at 11 44 09 PM" src="https://github.com/user-attachments/assets/466f39c7-1b04-44db-88a7-676efee39469" />

##### stright forward fill out

- Site Title
- username
- passwd
- install wordpress

  <img width="463" height="191" alt="Screenshot 2026-03-27 at 11 46 02 PM" src="https://github.com/user-attachments/assets/de228772-09f2-43e6-a6af-25e1121a2136" />

  - login
  - user name
  - passwd
  - success!
    
<img width="363" height="330" alt="Screenshot 2026-03-27 at 11 46 41 PM" src="https://github.com/user-attachments/assets/764fc968-7fb3-4a59-8df9-a2e1b68bf19d" />


