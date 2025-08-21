#!/bin/bash

## script Name :- 05-variables.sh
## Author:- Mani kumar Gundla
## Description:-(how to enter username and password in run time)
## created on:- 2025-08-21

    echo "usernamme:-"
    read -s USERNAME #here USERNAME acts as variavle and -s helps to not visiable the entered value 
    echo  "password:-"
    read -s PASSWORD #here password acts as variable and -s helps to not visiable the entered value 

    echo "$USERNAME" #this should not be enter in real script 
    echo "$PASSWORD" #this should not be entered in real time scenario it is just for practice