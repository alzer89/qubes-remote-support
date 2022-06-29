#!/bin/bash
dom0_username=$(cat /tmp/dom0_username)
hostname=$(cat /tmp/remote_hostname)


set -e

counter=0

## Required 13 retries during testing until onion v3 service was ready.
## Took 3:30 minutes.
## Another attempt:
## Required 33 retries during testing until onion v3 service was ready.
## Took 5:30 minutes.
echo "Now attempting to SSH into remote machine"

while true ; do
   counter="$((counter + 1))"
   if [ "$counter" -ge "500" ]; then
      echo "ERROR: SSH connection unsuccessful!"
      exit 1
   fi
   echo "Attempt number $counter..."
   if test -o xtrace ; then
      if ssh $dom0_username@$hostname ; then
         echo "INFO: SSH success."
      else
         sleep 10
      fi
   else
      if ssh $dom0_username@$hostname 2>/dev/null ; then
         echo "INFO: SSH success."
      else
         sleep 10
      fi
   fi
done
