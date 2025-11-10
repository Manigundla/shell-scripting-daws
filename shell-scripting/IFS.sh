#!/bin/bash

Source_dir=/etc/passwd
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m" 

if [ ! -f $Source_dir ]
then
    echo -e "$R source directory :- $Source_dir does'nt exist"
else 
    echo -e "$G source direcrtory is avaliable:- $Source_dir"
fi

while IFS=":" read -r username passwd user_id group_id userfullname home_dir shell_path
do 
    echo "username: $username"
    echo "userID: $user_id"
    echo "Group: $group_id"
done < $Source_dir

