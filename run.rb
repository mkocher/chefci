#!/usr/bin/env ruby
require 'environment'

loop do
  build = Build.next_to_run
  if build
    p "running"  
    run = Build.next_to_run.execute

    p "done running, output of build follows\n\n"
    p run.output

    p "rebooting in 60 seconds"
    sleep 60
    p "Ok, not really rebooting"
  else
    sleep 10
  end
end