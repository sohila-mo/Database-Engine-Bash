#!/bin/bash
echo "Enter Database Name: ";#create database
read nDBase;
if mkdir Databases/$nDBase 2>> errHistory.er; then
    mkdir Databases/$nDBase/Data;
    mkdir Databases/$nDBase/Metadata;
    printf "$nDBase created succesfully.\n";
else
    printf "Can not create $nDBase. Check errHistory.er for more details.\n";
fi