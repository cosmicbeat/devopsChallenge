#!/bin/bash
# This will install docker and doker compose and will bring up 3 container with LAMP stack and Nagios. 
# Then you can deploy your php application at /var/www/html

# Remenber to set you mariadb credentials with 
#'/usr/bin/mysqladmin' -u root password 'new-password'
#'/usr/bin/mysqladmin' -u root -h  password 'new-password'

# Copy me in your home folder and run me as root !

#Uncomment the line below if you have not update the system for a long time or docker fails to run
#yum -y update
#uncoment below dependancies if the instalation fails
#yum -y install -y yum-utils device-mapper-persistent-data lvm2

yum -y install docker docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose
systemctl enable docker.service
systemctl start docker.service
mkdir -p dockerized-lamp/DocumentRoot

#create some php sample page
echo "<?php phpinfo(); ?>" > dockerized-lamp/DocumentRoot/index.php

#create docker compose file
printf 'version: "3"
services:
    php-apache:
        image: php:7.2.1-apache
        ports:
            - 80:80
        volumes:
            - ./DocumentRoot:/var/www/html:z
        links:
            - 'mariadb'

    mariadb:
        image: mariadb:10.1
        volumes:
            - mariadb:/var/lib/mysql
        environment:
            TZ: "Europe/Rome"
            MYSQL_ALLOW_EMPTY_PASSWORD: "no"
            MYSQL_ROOT_PASSWORD: "rootpwd"
            MYSQL_USER: 'testuser'
            MYSQL_PASSWORD: 'testpassword'
            MYSQL_DATABASE: 'testdb'
            
    nagios:
        image: jasonrivers/nagios:latest
        ports:
            - 8081:80
        volumes:
            - nagiosetc:/opt/nagios/etc
            - nagiosvar:/opt/nagios/var
            - customplugins:/opt/Custom-Nagios-Plugins
            - nagiosgraphvar:/opt/nagiosgraph/var
            - nagiosgraphetc:/opt/nagiosgraph/etc

volumes:
    mariadb:
    nagiosetc:
    nagiosvar:
    customplugins:
    nagiosgraphvar:
    nagiosgraphetc:' > docker-compose.yml

chmod 755 docker-compose.yml

#provision the containers 
docker-compose up