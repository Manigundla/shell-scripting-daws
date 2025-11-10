#!/bin/bash

Source_dir="/tmp/shellscript.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m" 

if [ ! -d $Source_dir ]
then
    echo -e "$R source directory :- $Source_dir does'nt exist"
fi

file_to_delete=$(find $Source_dir -type f -mtime +21 -name "*.log")

while IFS= read -r line 
do 
    echo -e "deleting files:- $line"
    rm -rf
done <<< $file_to_delete



