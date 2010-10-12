What is this?
=============
It's a continuous integration server for Workstation Chef which is designed to be monitored with Pivotal's CI Monitor.

Is it more than that?
=====================
Maybe.  But not yet.  It was built with OSX in mind, as virtualization is not a good option.  If your target isn't OSX, vmware or ec2 are likely to be better options.

Why would I want this?
======================
Chef recipes are code.  Code that isn't tested isn't worth writing.  Write tests in your chef recipes.  Run chefci to know if your chef recipes still work.

How does it work?
=================
It assumes you've installed Deep Freeze on a mac, or have another solution for restoring the system partition to a known base state on reboot.  Chefci is installed on a persistent (unfrozen) partition.  On startup, it updates the system gems, installs bundler, and starts up the runner and the server.

What makes it tick?
===================
Chefci is composed of a script which runs a build script if any dependent github repositories have changed and a sinatra app that serves up the status.

How do I use it?
================
Contact me.  I'm happy to document the installation procedure, but not expecting any other users at this point.