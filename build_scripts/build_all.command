#!/bin/bash
set -e

cd ~ &&
sudo gem install soloist --no-ri --no-rdoc &&
mkdir -p chef/cookbooks/pivotal_workstation &&
cd chef/cookbooks/pivotal_workstation && 
curl -L http://github.com/pivotal/pivotal_workstation/tarball/master | gunzip | tar xvf - --strip=1 &&
cd ~ &&
cat > soloistrc <<SOLOISTRCCONTENTS
Cookbook_Paths:
- ./chef/cookbooks/
Recipes:
SOLOISTRCCONTENTS

for f in /Users/pivotal/chef/cookbooks/pivotal_workstation/recipes/*.rb; 
do 
  echo "$f" | sed 's/.*\/\([^\/]*\)\.rb/- pivotal_workstation::\1/' >> soloistrc
done

unset GEM_PATH && LOG_LEVEL=debug soloist &&
echo "GREAT SUCCESS"
