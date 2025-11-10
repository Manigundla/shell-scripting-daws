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


