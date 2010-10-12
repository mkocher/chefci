#!/usr/bin/env ruby

`cat #{File.expand_path(File.dirname(__FILE__) + "/../db/schema.sql")} | sqlite3 #{File.expand_path(File.dirname(__FILE__) + "/../db/production.sqlite3")}`

require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

Build.delete_all

build = Build.new(:name => "All Recipes")
build.git_repos << GitRepo.new(:github_user => "pivotalexperimental", :github_repository => "wschef", :git_branch => "master")
build.run_script = "/Volumes/Persistent/build_all_recipes.command;"
build.save!

build = Build.new(:name => "Chef CI")
build.git_repos << GitRepo.new(:github_user => "pivotalexperimental", :github_repository => "wschef", :git_branch => "master")
build.git_repos << GitRepo.new(:github_user => "pivotalexperimental", :github_repository => "ci_cookbook", :git_branch => "master")
build.run_script = "/Volumes/Persistent/build_ci_cookbook.command;"
build.save!