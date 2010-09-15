#!/usr/bin/env ruby
require 'environment'

build = Build.find_or_create(:github_user => "pivotalexeperimental", :github_repository => "wschef", :git_branch => "master")
build.run_script = "ls -l /"
build.save