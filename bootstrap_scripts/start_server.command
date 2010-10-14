#!/bin/bash -e

export DFXPSWD="pass"
/Library/Application\ Support/Faronics/Deep\ Freeze/deepfreeze -u user -p status | grep -q "BOOT FROZEN"
we_are_frozen=$?
if [ ${we_are_frozen} -ne "0" ]; then  
  echo "we aren't on a frozen deep freeze volume"
  exit 1
fi

echo "waiting 10 seconds before starting up"
sleep 10

/Volumes/Persistent/chefci/bootstrap_scripts/invoke_bootstrap_as_root

cd /Volumes/Persistent/chefci &&
sudo gem update --system &&
sudo gem install bundler -v 1.0.0;
./script/server
