#!/bin/bash -e

export DFXPSWD="pass"
/Library/Application\ Support/Faronics/Deep\ Freeze/deepfreeze -u user -p status | grep -q "BOOT FROZEN"
we_are_frozen=$?
if [ ${we_are_frozen} -ne "0" ]; then  
  echo "we aren't on a frozen deep freeze volume"
  exit 1
fi


cd /Volumes/Persistent/chefci/ 

until bundle check
  do sleep 5
done

./script/builder

echo "builder exited, rebooting in 60 seconds"
sleep 60;
sudo reboot;
