#!/bin/bash
# the table menu for the user 
Table_Menu2(){
    choices=("Create Tables" "List Tables"  "Display Tables" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Go Back");
     while [[ "$choice" != "Return To Main Menu" ]] 
    do
    select choice in "${choices[@]}"
    do
        case $choice in
            "Create Tables") . CreateTable.sh;break ;;
            "List Tables") . ListTables.sh; break;;
           "Display Tables") . DisplyTables.sh; break;;
            "Drop Table") . DropTable.sh; break;;
            "Insert Into Table") . InsertIntoTable.sh; break ;;
            "Select From Table") . SelectFromTable.sh; break ;;
            "Delete From Table") . DeleteFromTable.sh; break ;;
            "Go Back") . Main.sh; exit $? ;;
            *) echo "Invalid choice $REPLY";;
        esac
    done
    done
}

echo "Enter database name: "
read db_name;

# check if database exists
if [[ -d "Databases/$db_name"  ]]
then
    export  db_name=$db_name;
    echo "you are now connected to $db_name Database.";
    Table_Menu2;
else
    echo "Database does not Found .";
    . ./Main.sh
    
fi