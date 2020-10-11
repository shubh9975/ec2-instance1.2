#!/bin/bash
EC2_CHECK="$(aws ec2 describe-instances --filters "Name=instance-type,Values=t3.micro" --output=text |grep HelloWorld|awk '{print $3}')"
if [ $? -ne 0 ];
then
	echo "Failed"
else
	echo "pass"
fi


