#!/bin/bash
#
# Get SES statistics, it printes the missing header that the aws cli does not show...
# for getting output from a different profile than default's, pass the profile as a parameter:
#
#   ses_stats.sh "--profile devops"
#
#####################################

cat << EOF

O-> AWS SES statistics over the last two weeks (in 15-minute datapoints):

Timestamp                  Sent  Bounced  Complaints  Rejected
-------------------------  ----  -------  ----------  --------
EOF

aws ses get-send-statistics $1 | awk '{ print $6"  "$4"      "$2"          "$3"       "$5}' | sort -M

echo "o->"
