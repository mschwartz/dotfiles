#!/bin/bash

. ~/Dropbox/credentials/gmail.sh

#echo
#curl -u $GMAIL_USERNAME:$GMAIL_PASSWORD --silent "https://mail.google.com/mail/feed/atom" 
#|  grep -oPm1 "(?<=<title>)[^<]+" | sed '1d'


#MAILCOUNTER=`curl -u $GMAIL_USERNAME:$GMAIL_PASSWORD --silent "https://mail.google.com/mail/feed/atom" \ | xmllint --format - \ | sed -n 's#<fullcount>\(.*\)</fullcount>#\1#p'`
MAILCOUNTER=`curl -u $GMAIL_USERNAME:$GMAIL_PASSWORD --silent "https://mail.google.com/mail/feed/atom" \ | xmllint --nowarning --format - \ | sed -n 's#<fullcount>\(.*\)</fullcount>#\1#p'`
echo $MAILCOUNTER
echo >/tmp/foo $MAILCOUNTER
