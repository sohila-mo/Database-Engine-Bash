#!/bin/bash

echo "The database name you want to delete:" 
read  name

# Check the Database dir  is exists or not
if [  -d "Databases/$name"  ]; then
   # Remove  the Database dir  with approval
   rm -ir  "Databases/$name" 
   # Check if the  database dir is removed or not
   if [  -d "Databases/$name" ]; then
      echo "$name is not removed"
   else
      echo "$name is removed"
   fi
else
   echo "database does not exist"
fi