#!/bin/bash
# save the current dir in variable
DIR="$(pwd)/Databases"

if [ -d "$DIR" ] && [ "$(ls -A $DIR)" ]; then
   echo "Available Databases"
  ls $DIR # list all database even the hidden databases

else 
    echo "No Databases Found "
fi
