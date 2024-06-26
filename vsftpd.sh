#!/bin/bash

#Instalacion
apt-get upgrade -y
apt-get update -y
apt install vsftpd apache2 openssl -y

# Generar certificados autofirmados
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/juan.key -out /etc/ssl/certs/juan.crt -subj "/C=ES/ST=Madrid/L=Madrid/O=Organizacion/OU=Departamento/CN=juantest.com"

# Modificar configuracion
cp /etc/vsftpd.conf /etc/vsftpd.conf.bk

cat > /etc/vsftpd.conf << EOF
listen=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd.chroot_list
allow_writeable_chroot=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/juan.crt
rsa_private_key_file=/etc/ssl/private/juan.key
ssl_enable=YES
pasv_enable=YES
pasv_min_port=50000
pasv_max_port=50100
implicit_ssl=YES
listen_port=990
user_sub_token=\$USER
local_root=/var/www/\$USER/html
file_open_mode=0770
local_umask=0000
EOF
touch /etc/vsftpd.chroot_list
mkdir -p /var/www/juan/html
chown -R juan:www-data /var/www/juan
chmod -R g+s /var/www/juan
systemctl restart vsftpd
