#!/bin/bash
for i in `ls /sys/class/net/`; 
  do
    if `ethtool $i | grep detected | grep -i yes >/dev/null 2>&1` ; then
      echo -n "$i - "; ethtool $i | grep -i detected
      break
    fi
  done
#End script

