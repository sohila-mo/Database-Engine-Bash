#!/bin/bash
#List all tables in database
DIR="$(pwd)/Databases/$db_name/Data"
if [ -d "$DIR" ] && [ "$(ls -A $DIR)" ]; then
   echo "Available tables"
  ls $DIR
else 
    echo "No tables Found"
fi