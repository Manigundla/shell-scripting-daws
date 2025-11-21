#!/bin/bash

AMI="ami-0b4f379183e5706b9"
SG_ID="sg-015037b20dbb8522f"
INSTANCES=("MONGODB" "REDIT" "MYSQL" "RABBITMQ" "CATALOGUE" "USER" "CART" "SHIPPING" 
"PAYMENT" "DISPACTIH" "WEB")

for i in "${INSTANCES[@]}" 
do 
    echo "Instance is: $i"
    if [ $i == "MONGODB" ] || [ $i == "MYSQL" ] || [ $i == "SHIPPING" ]; then
        INSTANCE_TYPE="t3.small"
    else
        INSTANCE_TYPE="t2.micro"
    fi
    aws ec2 run-instances \
    --image-id $AMI \
    --instance-type $INSTANCE_TYPE \
    --security-group-ids $SG_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" 
done

