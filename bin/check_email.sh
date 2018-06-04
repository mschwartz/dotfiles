#!/bin/bash

. ~/Dropbox/credentials/gmail.sh

case "$1" in
  2) U=$GMAIL_USERNAME2
     P=$GMAIL_PASSWORD2
     ;;
  *)
     U=$GMAIL_USERNAME
     P=$GMAIL_PASSWORD
     ;;
esac

MAILCOUNTER=`curl -u $U:$P --silent "https://mail.google.com/mail/feed/atom" \ | xmllint --nowarning --format - \ | sed -n 's#<fullcount>\(.*\)</fullcount>#\1#p'`
echo $MAILCOUNTER
echo >/tmp/foo $MAILCOUNTER
