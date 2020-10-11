#!/bin/bash

filename="file/.terraform"

if[ -d $filename ]
then
	exit 
else
         cd file
	 terraform init
	 cd -
fi

