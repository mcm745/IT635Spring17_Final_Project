#!/bin/sh

echo " "
echo "Insert Authenticated Users"
echo " "

read -p "Enter login : "  login

read -p "Enter password : "  password

password_hash=`echo $password | openssl passwd -1 -salt saltvalud -stdin`

mysql -u$login -p$password  -t -e "use client_profile_db; insert into authenticated_users (username, password_hash) values ('$login','$password_hash');"
