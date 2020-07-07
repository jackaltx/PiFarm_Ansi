#!/bin/bash

mkdir example1
cd example1
mkdir -p group_vars host_vars library module_utils filter_plugins
mkdir -p roles/common/{tasks,handlers,templates,files,vars,defaults,meta,library,module_utils,lookup_plugins}
touch production staging site.yml roles/common/{tasks,handlers,templates,files,vars,defaults,meta}/main.yml
cd ..


mkdir example2
cd example2
mkdir -p inventories/{production,staging}/{group_vars,host_vars}
touch inventories/{production,staging}/hosts
mkdir -p group_vars host_vars library module_utils filter_plugins
mkdir -p roles/common/{tasks,handlers,templates,files,vars,defaults,meta,library,module_utils,lookup_plugins}
touch site.yml roles/common/{tasks,handlers,templates,files,vars,defaults,meta}/main.yml
  
