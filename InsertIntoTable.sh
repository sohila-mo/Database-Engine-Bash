#! /bin/bash
function validateTableName(){
    # validateTableName "$tableName"
    valid=0     #true
    IFS=' ' read -r -a  arr <<< $1;
    if (( ${#arr[@]} > 1 )); then 
        echo "  Table name can not contain spaces." >> errHistory.er;
        valid=1; #false
    fi

    if (( ${#arr[@]} == 0 )); then 
        echo "  Table name can not be empty." >> errHistory.er;
        valid=1; #false
    fi

    echo $valid;
}

function tableExists(){
    tableName=$1;
    valid=0     # valid;

    if [[ -f Databases/$db_name/Data/$tableName ]]; then
        echo "Table exists." >> errHistory.er;
    else
        echo "$tableName no such table." >> errHistory.er;
        valid=1;    # not-found
    fi

    echo $valid;
}


function insertRow(){
    # read columns info from tableName.metadata into  arr
    IFS=$'\n' read -d '' -r -a lines < "Databases/$db_name/Metadata/$tableName.metadata"

    # new record
    newRecord="";
    errorFlag=0; #true

    for i in "${!lines[@]}"
    do
        IFS=':' read -r -a column <<< "${lines[i]}";
        colName=${column[0]};
        colDataType=${column[1]};
        colPK=${column[2]};

        #test flags
        dataTypeFlag=0; #true
        pkFlag=0;   #true

        read -p "Enter $colName: " newColValue;
        numRegex='^[0-9]+$'

        # validate dataType
        if [[ $colDataType == "Int" ]]; then
            if ! [[ $newColValue =~ $numRegex ]]; then
                dataTypeFlag=1; #false
                errorFlag=1; #false
                echo "  Value must be a Intger.";
            fi 
        fi

        # validate if PK
        if [[ $colPK == "yes" ]]; then
            # get all column data from Data/tableName
            IFS=$'\n' read -d '' -r -a dataLines < "Databases/$db_name/Data/$tableName"  # all table
            
            #loop over column data to check pk if unique
            for j in "${!dataLines[@]}";
            do
                IFS=':' read -r -a record <<< "${dataLines[$j]}"; # record(row)
                if [[ ${record[i]} == $newColValue ]]; then
                    pkFlag=1; #false(not-unique)
                    errorFlag=1; #false
                    echo "  Primary key must be unique.";
                fi
            done
        fi


        #if value valid add it to newRecord string
        if [[ dataTypeFlag==0 && pkFlag==0 ]]; then
            if [[ $i == 0 ]]; then
                newRecord=$newColValue;
            else
                newRecord="$newRecord:$newColValue";
            fi
        else
            echo "In-valid record";
        fi
    done


    # save  newRecord in Data/$tableName
    if ! [[ $newRecord == "" ]]; then
        if [[ $errorFlag == 0 ]]; then
            if echo $newRecord >> "Databases/$db_name/Data/$tableName"; then
                echo "Record stored succesfully.";
            else
                echo "  Failed to store record.";
            fi
        else
            echo "  Failed to store record.";
        fi
    else
        echo "  Record is empty.";
    fi
}

# Read tableName from user
read -p "Enter table name: " tableName;

# Validate tableName
nameFlag=$(validateTableName "$tableName");
tableExistsFlag=$(tableExists "$tableName");


if [ $nameFlag  == 0 ] && [ $tableExistsFlag  == 0 ]; then
    insertRow
else
    echo "In-valid table name. Check errHistory.er for more details.";
fi