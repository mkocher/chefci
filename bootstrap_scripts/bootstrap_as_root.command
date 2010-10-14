#!/bin/bash

cp /etc/sudoers /tmp/sudoers_tmp && 
chmod 666 /tmp/sudoers_tmp && 
echo "%admin        ALL=(ALL) NOPASSWD: ALL" >> /tmp/sudoers_tmp && 
chmod 0440 /tmp/sudoers_tmp && 
visudo -csf /tmp/sudoers_tmp && 
mv /tmp/sudoers_tmp /etc/sudoers
