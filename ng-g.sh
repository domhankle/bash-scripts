#!/usr/bin/bash

COMPONENT_NAME=$1
DIRECTORY=$2


checkArgs(){

  if [ -z $COMPONENT_NAME ]; then
    echo You need to specify a component name;
    return 1  
  fi

  if [ -z $DIRECTORY ]; then
    echo You need to specify a directory path for the component;
    return 1
  fi
  return 0

}

generateComponentFiles(){
  
  cat << EOF
Generating HTML, SCSS, SPEC, and TS file for ${COMPONENT_NAME} at ${DIRECTORY}.
EOF
  
  if [ ! -d $DIRECTORY ]; then
    mkdir -p $DIRECTORY
  fi

  touch ${DIRECTORY}/${COMPONENT_NAME}.component.ts
  touch ${DIRECTORY}/${COMPONENT_NAME}.component.html
  touch ${DIRECTORY}/${COMPONENT_NAME}.component.scss
  touch ${DIRECTORY}/${COMPONENT_NAME}.component.spec.ts
  
}  

checkArgs

if [ $? = 0 ]; then
    generateComponentFiles
fi

