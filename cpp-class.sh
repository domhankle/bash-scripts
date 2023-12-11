#!/usr/bin/bash

CLASS_NAME=$1
PATH_FOR_CLASS=$2

checkArgs(){
  if [ -z $CLASS_NAME ]; then
    echo You need to enter a name for the CPP class to generate.
    return 1;
  fi
  if [ -z $PATH_FOR_CLASS ]; then
    echo No path was specified for this class, it will be generated in the current working directory.
    $PATH_FOR_CLASS=.
  fi
  if [ $3 = -m ]; then
    return 2
  fi
  return 0
}

populateMainTemplate(){
  local MAIN_CLASS_FILE=${PATH_FOR_CLASS}/${CLASS_NAME}.cpp
  
}

generateMainClassFile(){
  touch ${PATH_FOR_CLASS}/${CLASS_NAME}.cpp
}

generateClassFiles(){
  touch ${PATH_FOR_CLASS}/${CLASS_NAME}.cpp
  touch ${PATH_FOR_CLASS}/${CLASS_NAME}.h   
}


checkArgs

if [ $? = 0 ]; then
  generateClassFiles
elif [ $? = 2 ]; then
  generateMainClassFile
fi

