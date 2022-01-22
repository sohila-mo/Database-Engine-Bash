#!/bin/bash
#delet table from Database

echo " Enter the table Name you want to delete: " 
read  tableName

# Check the directory is exists or not
if [  -f "Databases/$db_name/Data/$tableName" ] && [  -f "Databases/$db_name/Metadata/$tableName.metadata" ]  ; then
   # Remove  the directory with approval 
   rm -ir  "Databases/$db_name/Data/$tableName"
   rm -ir  "Databases/$db_name/Metadata/$tableName.metadata" 
   # Check the directory is removed or not
   if [  -f "Databases/$db_name/Data/$tableName" ] && [  -f "Databases/$db_name/Metadata/$tableName.metadata" ]; then
      echo "$tableName is not removed"
   else
      echo "$tableName is removed"
   fi
else
   echo "table does not exist"
fi