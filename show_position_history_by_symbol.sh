#!/bin/sh

echo " "
echo "Show Position History By Symbol"
echo " "

read -p "Enter login : "  login

read -p "Enter password : "  password

password_hash=`echo $password | openssl passwd -1 -salt saltvalud -stdin`

ret=$(mysql client_profile_db -u$login -p$password -s -N -e "select count(*) from authenticated_users where username = '$login' and password_hash =  '$password_hash';")

if [ "$ret" -gt 0 ]; then
   echo "user authenticated"
else
   echo "user not authenticated ... exiting"
   exit
fi

read -p "Enter a stock symbol : " symbol

#mysql -uadmin -padmin_pass  -t -e "use client_profile_db; call show_position_history_by_symbol ('$1');"
mysql -uadmin -padmin_pass  -t -e "use client_profile_db; call show_position_history_by_symbol ('$symbol');"
