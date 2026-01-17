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

    INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI \
    --instance-type $INSTANCE_TYPE \
    --security-group-ids $SG_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" \
    --no-cli-pager  \
    --query "Instances[0].InstanceId" \
    --output text)

       # Wait until instance is running (so IPs are available)
    aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"

    # Pick public IP only for MONGODB, private for others
    if [ "$i" == "MONGODB" ]; then
        IP_FIELD="PublicIpAddress"
    else
        IP_FIELD="PrivateIpAddress"
    fi

    # Fetch the chosen IP
    IP_ADDRESS=$(aws ec2 describe-instances \
        --instance-ids "$INSTANCE_ID" \
        --query "Reservations[0].Instances[0].$IP_FIELD" \
        --output text)


    echo "Created $i with $IP_FIELD: $RECORD_IP"

    # UPSERT DNS record in Route53 (create or update)

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