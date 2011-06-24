#!/usr/bin/env ruby

`cat #{File.expand_path(File.dirname(__FILE__) + "/../db/schema.sql")} | sqlite3 #{File.expand_path(File.dirname(__FILE__) + "/../db/production.sqlite3")}`

require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

Build.delete_all

# build = Build.new(:name => "Chef CI")
# build.git_repos << GitRepo.new(:github_user => "pivotalexperimental", :github_repository => "wschef", :git_branch => "master")
# build.git_repos << GitRepo.new(:github_user => "pivotalexperimental", :github_repository => "ci_cookbook", :git_branch => "master")
# build.run_script = "/Volumes/Persistent/chefci/build_scripts/build_ci_cookbook.command;"
# build.save!

build = Build.new(:name => "Soloist All")
build.git_repos << GitRepo.new(:github_user => "mkocher", :github_repository => "soloist", :git_branch => "master")
build.git_repos << GitRepo.new(:github_user => "pivotal", :github_repository => "pivotal_workstation", :git_branch => "master")
build.run_script = "/Volumes/Persistent/chefci/build_scripts/build_all.command;"
build.save!
