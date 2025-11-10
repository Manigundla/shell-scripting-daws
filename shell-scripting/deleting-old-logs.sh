#!/bin/bash

Source_dir="/tmp/shellscript.log"

if [ ! -d $Source_dir ]
then
    echo -e "$R source directory :- $Source_dir does'nt exist"
fi

file_to_delete=$(find $Source_dir -type f -mtime +21 -name "*.log")

echo "$file_to_delete"