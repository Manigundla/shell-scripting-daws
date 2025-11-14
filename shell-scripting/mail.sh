#!/bin/bash

TO_TEAM=$1
ALERT_TYPE=$2
BODY=$3
TO_ADDRESS=$4
SUBJECT=$5
ESCAPED_KEYWORD=$(printf '%s\n' "$BODY" | sed -e 's/[]\/$*.^[]/\\&/g');

FINAL_BODY=$(sed -e "s/TO_TEAM/$TO_TEAM/g" "s/ALERT_TYPE/$ALERT_TYPE/g" "s/BODY/$ESCAPED_BODY/g" templet.html)
#FINAL_BODY=$(sed \
  #-e "s|TO_TEAM|$TO_TEAM|g" \
  #-e "s|ALERT_TYPE|$ALERT_TYPE|g" \
 # -e "s|BODY|$BODY|g" \
 # templet.html
#) we can even use this for more cleaner and safety without using $ESCAPED_KEYWORD
echo "$FINAL_BODY" | mail -s mail -s "$(echo -e "$SUBJECT\nContent-Type: text/html")" "$TO_ADDRESS"