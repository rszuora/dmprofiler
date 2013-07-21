#!/bin/bash
#
#  Profile a table!
#
# First input should be the sqlite database file name, the
# second input should be the table to be profiled, the third
# input should be the file name that was used to populate
# the db. Being a csv file it will have the columns names
# in the first row.
#
#
#  richard.sawey@zuora.com
#
DB=$1
TABLE=$2
CSVFILE=$3
COLIST=`head -1 $CSVFILE`
ROWCOUNT=`sqlite3 $DB "select count(*) from $TABLE;"`
echo $ROWCOUNT
sqlite3 $DB "drop table profile;"
sqlite3 $DB "create table profile(column_name, min_value, max_value, num_nulls, num_values, data_type, num_rows, pct_null, pct_values);"


# head -1 $CSVFILE
# IFS=$',' 
IFS=','
for COL in $COLIST 
do 
    # echo "insert into profile(column_name, rowcount) values('$COL', $ROWCOUNT);"
    echo "    $COL"  
    MIN=`sqlite3 $DB "select min([$COL]) from $TABLE;"`
    MAX=`sqlite3 $DB "select max([$COL]) from $TABLE;"`
    NULLCOUNT=`sqlite3 $DB "select $ROWCOUNT - count([$COL]) from $TABLE;"`
    sqlite3 $DB "insert into profile(column_name, min_value, max_value, num_nulls, num_rows) values( '$COL', '$MIN', '$MAX', $NULLCOUNT, $ROWCOUNT);"
done
unset IFS
sqlite3 $DB "select * from profile;"
