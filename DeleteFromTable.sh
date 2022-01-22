#! /bin/bash
echo -e "Enter TableName:\c" 
read TableName
    if ! [[ -f Databases/$db_name/Data/$TableName ]]; then
    echo "Table does exist"
else
    echo -e "Enter primary key: \c"
    read recordNum
    if ! [[ $recordNum =~ [`cut -d':' -f1 Databases/$db_name/Data/$TableName | grep -x $recordNum`] ]]; then
	 	 echo "record not found"

    else
        sed -i /$recordNum/d Databases/$db_name/Data/$TableName
        echo "record deleted successfully"

    fi
fi
