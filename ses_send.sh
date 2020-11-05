#!/bin/bash
#
# AWS SES test send...
# for sending with a different profile than default's, pass the profile as a parameter:
#
#   ses_send.sh "--profile devops"
#
#####################################

cat << EOF

O-> Sending a test AWS SES email:

EOF

aws ses send-email --from testing@seeraspain.com --destination file://destination.json --message file://message.json $1 

echo "+---> transaction ID."
