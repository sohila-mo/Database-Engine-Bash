#!/bin/bash
function validate_Name(){
    # Function validate tableName 
    valid=0     #true
    IFS=' ' read -a arr <<< $1;
    if (( ${#arr[@]} > 1 )); then 
        echo " name can not contain spaces." >> errHistory.er;
        valid=1; #false
    fi

    if (( ${#arr[@]} == 0 )); then 
        echo " name can not be empty." >> errHistory.er;
        valid=1; #false
    fi

    # validate Table name does not start with number
    first="${arr[0]:0:1}"
    if [[ $first =~ [0-9] ]]; then
        echo " name can not start with number." >> errHistory.er;
        valid=1; #false
    fi


    # validate Table name has at least one letter
    if [[ "$1" =~ [A-Za-z] ]]; then
        echo " Valid Table name" >> errHistory.er;
    else
        echo " name must contain at least one letter." >> errHistory.er;
        valid=1;    #false
    fi

    echo $valid;
}


function TableExists(){
    db_name=$1;
    TableName=$2;

    valid=0     # valid;

    if [[ -f Databases/$db_name/Data/$TableName ]]; then
        echo " Table already exists." >> errHistory.er;
        valid=1;    # not-valid
    fi

    echo $valid;
}


function createColumns(){
    read -p "Enter number of columns: " nCols;
     
    for (( i=0; i<$nCols; i++ ))
    do
        colMeta="";
        read -p "Enter column name: " colName;
        # Check column name
        nameFlag=$(validate_Name "$colName");
        if [[ $nameFlag == 0 ]]; then
            colMeta="$colName";
            # select datatype (string, Intger)
            read -p "Choose column's datatype String(s) Int(n): (s/I)" colDataType;
            if [[ $colDataType == "s" || $colDataType == "S" ]]; then
                colMeta="$colMeta:string";
            elif [[ $colDataType == "I" || $colDataType == "i" ]]; then
                colMeta="$colMeta:Int";
            fi
            # Is it Primary-Key (PK): (y/n):
            read -p "Is it Primary-Key (PK): (y/n)" primK;
            if [[ $primK == "y" || $primK == "Y" ]]; then
                colMeta="$colMeta:PK";
            elif [[ $primK == "n" || $primK == "N" ]]; then
                colMeta="$colMeta";
            fi

            # create row containing column-info in Table.metadata (colName:dataType:PK)
            echo $colMeta >> "Databases/$db_name/Metadata/$TableName.metadata";
            
        else
            echo "In-valid column name";
        fi
    done
}

read -p "Enter Table name: " TableName;

nameFlag=$(validate_Name "$TableName");
TableExistsFlag=$(TableExists "$db_name" "$TableName");


if [ $nameFlag == 0 ] && [ $TableExistsFlag == 0 ]; then
    # create Data/TableName
    if touch "Databases/$db_name/Data/$TableName" 2> errHistory.er; then
        echo "Empty Table created sucessfully." >> errHistory.er;
        # create Metadata/TableName.metadata
        if touch "Databases/$db_name/Metadata/$TableName.metadata" 2> errHistory.er; then
            echo "Metadata file created sucessfully." >> errHistory.er;
        else
            echo "can not create metadata. Check errHistory.er for more details.";
        fi

        if createColumns; then
            echo "Table $TableName created sucessfully.";
            cat "Databases/$db_name/Metadata/$TableName.metadata";
        else
            echo " can not create $TableName."
        fi
    else
        echo "can not create Table. Check errHistory.er for more details.";
    fi

else
    echo "Can not create Table. Check errHistory.er for more details.";
fi