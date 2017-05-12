#!/bin/sh

echo " "
echo "Show Historical Prices"
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

read -p "Enter a start date in a date range : " sdate

read -p "Enter an end date in a date range : " edate

if [ -z "$sdate" ] && [ -z "$edate" ] ; then
   mysql -u$login -p$password  -t -e "use client_profile_db; call show_historical_prices ('$symbol',null,null);"
elif [ -z "$sdate" ] ; then
   mysql -u$login -p$password  -t -e "use client_profile_db; call show_historical_prices ('$symbol',null,'$edate');"
elif [ -z "$edate" ] ; then
   mysql -u$login -p$password  -t -e "use client_profile_db; call show_historical_prices ('$symbol','$sdate',null);"
else
   mysql -u$login -p$password  -t -e "use client_profile_db; call show_historical_prices ('$symbol','$sdate','$edate');"
fi
#mysql -uadmin -padmin_pass  -t -e "use client_profile_db; call show_historical_prices ('$1','$2','$3');"
