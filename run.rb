#!/usr/bin/env ruby
require 'environment'

TIME_BETWEEN_CHECKS = 20

loop do
  build = Build.next_to_run
  if build
    p "running"  
    run = Build.next_to_run.execute

    p "done running, output of build follows\n\n"
    p run.output

    p "rebooting in 120 seconds"
    sleep 120
    system!("sudo reboot")
    p "Ok, not really rebooting"
  else
    p "waiting for a build"
    sleep TIME_BETWEEN_CHECKS
  end
end
