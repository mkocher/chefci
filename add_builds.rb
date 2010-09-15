#!/usr/bin/env ruby
require 'environment'

build = Build.find_or_create_by_github_user_and_github_repository_and_git_branch(:github_user => "mkocher", :github_repository => "touchable", :git_branch => "master")
build.run_script = "/Volumes/Persistent/bootstrap.command;"
build.save