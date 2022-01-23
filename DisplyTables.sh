#!/bin/bash
echo "Enter Database Name :"
read db_name

echo "Enter Table Name :"
read TableName

if [ -f "Databases/$db_name/Data/$TableName" ] && [ -f  "Databases/$db_name/Metadata/$TableName.metadata" ]; then 

    awk -F: 'BEGIN { ORS=":" }; { print $1 }' Databases/$db_name/Metadata/$TableName.metadata 
    printf "\n"
    cat  Databases/$db_name/Data/$TableName
    else 
    echo "No such Table"
fi