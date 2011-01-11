#!/bin/bash
set -e

cd ~ &&
sudo gem install soloist --no-ri --no-rdoc &&
mkdir -p chef/cookbooks/pivotal_workstation &&
cd chef/cookbooks/pivotal_workstation && 
curl -L http://github.com/mkocher/pivotal_workstation/tarball/master | gunzip | tar xvf - --strip=1 &&
cd ~ &&
cat > soloistrc <<SOLOISTRCCONTENTS
Cookbook_Paths:
- ./chef/cookbooks/
Recipes:
- pivotal_workstation::ack
- pivotal_workstation::bash_path_order
- pivotal_workstation::bash_profile
- pivotal_workstation::bash_profile-better_history
- pivotal_workstation::defaults_fast_key_repeat_rate
- pivotal_workstation::dock_preferences
- pivotal_workstation::ec2_api_tools
- pivotal_workstation::finder_display_full_path
- pivotal_workstation::git
- pivotal_workstation::git_config_global_defaults
- pivotal_workstation::git_scripts
- pivotal_workstation::google_chrome
- pivotal_workstation::inputrc
- pivotal_workstation::mysql
- pivotal_workstation::osx_turn_on_locate
- pivotal_workstation::rvm
- pivotal_workstation::safari_preferences
- pivotal_workstation::set_multitouch_preferences
- pivotal_workstation::text_mate
- pivotal_workstation::textmate_set_defaults
- pivotal_workstation::turn_on_ssh
- pivotal_workstation::user_owns_usr_local
- pivotal_workstation::workspace_directory
SOLOISTRCCONTENTS

unset GEM_PATH && LOG_LEVEL=debug soloist &&
echo "GREAT SUCCESS"
