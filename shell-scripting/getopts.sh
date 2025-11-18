#!/bin/bash

NAME=""
WISHES="How are you doing?"


USAGE(){
    echo "USAGE: $(BASENAME $0) -n<name> -w<wishes>"
    echo "Options:"
    echo "-n, specifies the name (mandatory)"
    echo "-w, specifies the wishes(optional)"
    echo "-h, Displays Help and Exits"
}

while getopts "-n:-w:-h" opt;
do
    case $opt in
        n) NAME="$OPTARG";;
        W) WISHES="$OPTARG";;
        h) USAGE; exit;;
        :) USAGE; exit;;
    esac
done

if [ -z "$NAME" ]; then
#if [ -z "$NAME" ] || [ -z "$WISHES" ]; then
    echo "ERROR: -n is mandatory"
    USAGE
    exit 1
fi 

echo "Hello, $NAME. $WISHES. I'm learing DevOps"