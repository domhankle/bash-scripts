#!/usr/bin/bash

CLASS_NAME=$1
FOLDER_NAME=$2
SRC_FOLDER=$(pwd)/src
INC_FOLDER=$(pwd)/include
CPP_FILE_PATH=""
HEADER_FILE_PATH=""

checkArgs(){
  
  if [ -z $CLASS_NAME ]; then
    echo You need to enter a name for the CPP class to generate.
    return 1
  fi
  if [ $FOLDER_NAME = "-m" ]; then
    return 2
  fi
  return 0
}

populateMainTemplate(){
  local MAIN_TEMPLATE=$(cat << EOT
#include <iostream>

int main(){
  return 0;
}  
EOT
)
  echo -e "${MAIN_TEMPLATE}" >> $CPP_FILE_PATH
  echo Generating Main Class at ${CPP_FILE_PATH}
}

populateHeaderFileTemplate(){
  local HEADER_TEMPLATE=$(cat << EOT
#ifndef ${CLASS_NAME^^}_H
#define ${CLASS_NAME^^}_H

#include <string>

class ${CLASS_NAME}{
  public:
    /**
     * ${CLASS_NAME} Constructor
     */
     ${CLASS_NAME}();

    /**
     * ${CLASS_NAME} Destructor
     */
     ~${CLASS_NAME}();
  private:
};

#endif
EOT
)
  echo -e "${HEADER_TEMPLATE}" >> $HEADER_FILE_PATH
  echo Generating Header File at ${HEADER_FILE_PATH}
}

populateCPPFileTemplate(){
  local CPP_TEMPLATE=$(cat << EOT
#include "${CLASS_NAME}.h"

${CLASS_NAME}::${CLASS_NAME}()
{

}

${CLASS_NAME}::~${CLASS_NAME}()
{

}
EOT
)

  echo -e "${CPP_TEMPLATE}" >> $CPP_FILE_PATH
  echo Generating CPP File at ${CPP_FILE_PATH}
}

generateMainClassFile(){
  mkdir -p ${SRC_FOLDER}
  CPP_FILE_PATH=${SRC_FOLDER}/${CLASS_NAME}.cpp
  if [ ! -e $CPP_FILE_PATH ]; then
    touch ${CPP_FILE_PATH}
    populateMainTemplate
  fi
}

generateClassFiles(){
  if [ -z $FOLDER_NAME ]; then
    echo No folder was specified to store these class files in.
    CPP_FILE_PATH=${SRC_FOLDER}/${CLASS_NAME}.cpp 
    HEADER_FILE_PATH=${INC_FOLDER}/${CLASS_NAME}.h
  else
    mkdir -p ${SRC_FOLDER}/${FOLDER_NAME}
  echo Populating Header File Template
    mkdir -p ${INC_FOLDER}/${FOLDER_NAME}
    CPP_FILE_PATH=${SRC_FOLDER}/${FOLDER_NAME}/${CLASS_NAME}.cpp
    HEADER_FILE_PATH=${INC_FOLDER}/${FOLDER_NAME}/${CLASS_NAME}.h
  fi
  if [ ! -e "${CPP_FILE_PATH}" ]; then 
    touch ${CPP_FILE_PATH}
    touch ${HEADER_FILE_PATH}
    populateHeaderFileTemplate
    populateCPPFileTemplate   
  fi
}

checkArgs
ARG_STATUS=$?

if [ $ARG_STATUS = 0 ]; then
  generateClassFiles
  echo Generated Class Files for ${CLASS_NAME}
elif [ $ARG_STATUS = 2 ]; then
  generateMainClassFile
  echo Generated Main Class called ${CLASS_NAME} at ${CPP_FILE_PATH}
else 
  echo Something went wrong!
fi

