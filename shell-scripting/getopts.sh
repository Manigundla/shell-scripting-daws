#!/bin/bash

NAME=""
WISHES="How are you doing?"


USAGE(){
    echo "USAGE: $(basename $0) -n<name> -w<wishes>"
    echo "Options:"
    echo "-n, specifies the name (mandatory)" 
    echo "-w, specifies the wishes(optional)"
    echo "-h, Displays Help and Exits"
}

while getopts "n:w:h" opt;
do
    case $opt in
        n) NAME="$OPTARG";; # -n option found, its argument is in $OPTARG
        w) WISHES="$OPTARG";; # -w option found, its argument is in $OPTARG
        h) USAGE; exit;; # -h option found (help flag)
        ?) USAGE; exit 1;; # Catches an invalid option (e.g., -x)
        :) USAGE; exit;; # Catches missing argument for n or w
    esac
done

if [ -z "$NAME" ]; then
#if [ -z "$NAME" ] || [ -z "$WISHES" ]; then
    echo "ERROR: -n is mandatory"
    USAGE
    exit 1
fi 

echo "Hello, $NAME. $WISHES. I'm learing DevOps"