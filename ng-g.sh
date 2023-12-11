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

populateTSFile(){

  local TS_FILE_PATH=${DIRECTORY}/${COMPONENT_NAME}.component.ts
  local SCSS_FILE_PATH=${DIRECTORY}/${COMPONENT_NAME}.component.scss

  cat << EOF
Creating TS File Template at ${TS_FILE_PATH}...
EOF

  if [ -e $TS_FILE_PATH ]; then
    local TS_TEMPLATE=$(cat << EOT
import { Component } from '@angular/core';

import '${SCSS_FILE_PATH}'

@Component({
  selector: '${COMPONENT_NAME}-selector',
  template: require('./example.component.html')
})
export class ExampleComponent implements OnInit {

  constructor() { }
}
EOT
)
  echo -e "$TS_TEMPLATE" >> $TS_FILE_PATH
fi

}

populateSCSSFile(){

  local SCSS_FILE_PATH=${DIRECTORY}/${COMPONENT_NAME}.component.scss
  cat << EOF
Creating SCSS File Template at ${SCSS_FILE_PATH}...
EOF
  
  if [ -e $SCSS_FILE_PATH ]; then
    echo -e ${COMPONENT_NAME} { "\n""\n"} >> $SCSS_FILE_PATH
    populateTSFile
  fi


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
  
  populateSCSSFile
}  

checkArgs

if [ $? = 0 ]; then
    generateComponentFiles
fi

