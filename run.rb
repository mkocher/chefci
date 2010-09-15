#!/usr/bin/env ruby
require 'environment'

TIME_BETWEEN_CHECKS = 10

loop do
  build = Build.next_to_run
  if build
    p "running"  
    run = Build.next_to_run.execute

    p "done running, output of build follows\n\n"
    p run.output

    p "rebooting in #{SLEEP_TIME} seconds"
    sleep TIME_BETWEEN_CHECKS
    p "Ok, not really rebooting"
  else
    p "waiting for a build"
    sleep TIME_BETWEEN_CHECKS
  end
end