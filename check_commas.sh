#!/bin/bash
while read line
do
#  echo -n "$line"
  echo $line | tr -dc , | wc -c
done < $1
