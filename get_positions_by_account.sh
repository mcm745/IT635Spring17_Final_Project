#!/bin/sh

echo " "
echo "Get Positions By Account"
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

read -p "Enter account owner first name : " fname 

read -p "Enter account owner last name : " lname 

#mysql -uadmin -padmin_pass  -t -e "use client_profile_db; call get_positions_by_account ('$1','$2');"
mysql -u$login -p$password -t -e "use client_profile_db; call get_positions_by_account ('$fname','$lname');"
