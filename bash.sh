#!/bin/bash

TXT_FILE=/workspace/Grymco/data.txt

if [ ! -f $TXT_FILE ]; then
  echo "File $TXT_FILE does not exists"
  exit 
fi

java -Xmx512m -DtextFileFullPath=data.txt -jar ./akka.jar
java -Xmx512m -jar ./spray.jar &

printf "reading file and curl-spray:\n"
COUNTER=0 
while read line          
do           
  let "COUNTER += 1"
  url="localhost:8080/simple?name=$line"
  curl --request GET $url 
  printf "\n"
 
  if (( $COUNTER >= 5 )); then
    break
  fi 
done < $TXT_FILE.wordsCounter

