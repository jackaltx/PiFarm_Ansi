#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "illegal number of parameters"
    exit
fi

mkdir -p roles/$1/{tasks,handlers,templates,files,vars,defaults,meta,library,module_utils,lookup_plugins}
touch roles/$1/{tasks,handlers,templates,files,vars,defaults,meta}/main.yml

