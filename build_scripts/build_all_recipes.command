#!/bin/bash

cd ~ &&
/Volumes/Persistent/chefci/bin/git clone git://github.com/pivotalexperimental/wschef.git &&
cd wschef &&
cp chef/all_recipes.json chef/workstation.json &&
./install_chef.rb &&
LOG_LEVEL=debug ./run &&
echo "GREAT SUCCESS"
