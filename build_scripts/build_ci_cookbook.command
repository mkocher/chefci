#!/bin/bash

cd ~ &&
/Volumes/Persistent/chefci/bin/git clone git://github.com/pivotalexperimental/wschef.git &&
/Volumes/Persistent/chefci/bin/git clone git://github.com/pivotalexperimental/ci_cookbook.git &&
ln -s ~/ci_cookbook/ ~/wschef/cookbook_links/workstation_cookbook &&
cd wschef &&
./install_chef.rb &&
LOG_LEVEL=debug ./run &&
echo "GREAT SUCCESS"
