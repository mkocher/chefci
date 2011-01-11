#!/bin/bash
set -e

cd ~ &&
sudo gem install soloist &&
mkdir -p chef/cookbooks/pivotal_workstation &&
cd chef/cookbooks/pivotal_workstation && 
curl -L http://github.com/mkocher/pivotal_workstation/tarball/master | gunzip | tar xvf - --strip=1 &&
cd ~ &&
cat > soloistrc <<SOLOISTRCCONTENTS
Cookbook_Paths:
- ./chef/cookbooks/
Recipes:
- pivotal_workstation::bash_path_order
- pivotal_workstation::bash_profile
- pivotal_workstation::bash_profile-better_history
SOLOISTRCCONTENTS

LOG_LEVEL=debug soloist &&
echo "GREAT SUCCESS"