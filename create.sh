#!/bin/bash
#
#Creacion usuarios

username="marco1"
password="marco"

useradd -ms /usr/sbin/nologin $username
#adduser --disabled-password --gecos "" antonio
#
echo "$username:$password" | sudo chpasswd
mkdir -p /var/www/$username/html
chown -R $username:www-data /var/www/$username


