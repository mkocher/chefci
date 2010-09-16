#!/usr/bin/env ruby
require 'environment'

TIME_BETWEEN_CHECKS = 20

loop do
  build = Build.next_to_run
  if build
    p "Running..."  
    run = Build.next_to_run.execute

    p "Done running, output of build follows\n\n"
    p run.output

    p "Rebooting in 120 seconds"
    sleep 120
    system("sudo reboot")
  else
    p "Waiting for a build"
    sleep TIME_BETWEEN_CHECKS
  end
end
