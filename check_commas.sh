#!/bin/bash
#
# ./check_commas.sh longsample.csv | nl | sort -k2 | tail
# nl will number the output lines, sort will sort by number of commas
#
while read line
do
#  echo -n "$line"
  echo $line | tr -dc , | wc -c
done < $1
