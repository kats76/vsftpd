#!/bin/bash

echo "Dame un nombre"
read nombre1
echo "¿Quieres que tenga bash? (s/n)"
read respuesta
if [[ $respuesta == "N" ]] || [[ $respuesta == "n" ]] || [[ $respuesta == "no" ]]
then
 adduser $nombre1
 usermod -s /usr/sbin/nologin $nombre1

else
 adduser $nombre1
fi

