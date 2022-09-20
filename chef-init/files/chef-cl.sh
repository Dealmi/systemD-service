#!/bin/sh 
while [ TRUE ]; do
    #Launching Chef-client which connects to chef-infra server and gets orders from it
    /opt/chef/bin/chef-client
    # A time between client launching.
    sleep "$1"
done





