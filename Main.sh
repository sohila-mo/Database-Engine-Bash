#!/bin/bash
#create main menu 
chioces=("Create New Database" "List Databases" "Connect Database" "Drop Database" "Exit")
while [[ "$choice" != "Exit" ]] 
do
	select choice in "${chioces[@]}"
	do
		case $choice in
        	"Create New Database"). creatDB.sh; break ;;
			"List Databases") . List_DB.sh; break ;;
			"Connect Database") . Connection.sh break ;;
			"Drop Database") . Drop_DB.sh; break ;;
			"Exit")  break; exit $?;;
			*) echo "Incorrect Choice  $REPLY";;
		esac
	done
done