#! /bin/bash
echo -e "Select * From Table Name:\c"
read TableName
if ! [[ -f Databases/$db_name/Data/$TableName ]]; then
    echo "Table does exist"
else
    echo -e " Where ID : \c"
   read recordNum
   export recordNum
    if ! [[ $recordNum =~ [`cut -d':' -f1 Databases/$db_name/Data/$TableName | grep -x $recordNum`] ]]; then
	 	 echo "record not found"

    else
        awk -F: '{ if ($1 == "'"$recordNum"'" ) print $0}' Databases/$db_name/Data/$TableName   

    fi
fi