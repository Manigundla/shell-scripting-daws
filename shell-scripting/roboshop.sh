#!/bin/bash

AMI="ami-0b4f379183e5706b9"
SG_ID="sg-015037b20dbb8522f"
INSTANCES=("MONGODB" "REDIS" "MYSQL" "RABBITMQ" "CATALOGUE" "USER" "CART" "SHIPPING" 
"PAYMENT" "DISPATCH" "WEB")
ZONE_ID="Z05485001W8WH1XFM7U3Q"
DOMAIN_NAME="chainverse.online"

for i in "${INSTANCES[@]}" 
do 
    echo "Instance is: $i"
      #deciding which type of instance to use.
    if [ $i == "MONGODB" ] || [ $i == "MYSQL" ] || [ $i == "SHIPPING" ]
    then
        INSTANCE_TYPE="t3.small"
    else
        INSTANCE_TYPE="t2.micro"
    fi
        # Decide which IP to use for DNS: WEB = public, others = private
    if [[ "$i" == "WEB" ]]; then
        IP_FIELD="PublicIpAddress"
    else
        IP_FIELD="PrivateIpAddress"
    fi

    IP_ADDRESS=$(aws ec2 run-instances \
    --image-id $AMI \
    --instance-type $INSTANCE_TYPE \
    --security-group-ids $SG_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" \
    --no-cli-pager  \
    --query 'Instances[0].PrivateIpAddress' --output text)

    aws route53 change-resource-record-sets \
    --hosted-zone-id $ZONE_ID \
    --change-batch '
  {
    "Comment": "Creating a record set for cognito endpoint"
    ,"Changes": [{
      "Action"              : "UPSERT"
      ,"ResourceRecordSet"  : {
        "Name"              : "'$i'.'$DOMAIN_NAME'"
        ,"Type"             : "A"
        ,"TTL"              : 1
        ,"ResourceRecords"  : [{
            "Value"         : "'$IP_ADDRESS'"
        }]
      }
    }]
  }
  '
done