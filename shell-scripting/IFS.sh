#!/bin/bash

Source_dir=/etc/passwd
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m" 

if [ ! -f $Source_dir ]
then
    echo -e "$R source directory :- $Source_dir does'nt exist"
fi

while IFS=":" read -r username passwd userID groupID
do 
    echo "username:$username"
    echo "userID:$userID"
    echo "Group:$gropID"
done <<< $Source_dir
