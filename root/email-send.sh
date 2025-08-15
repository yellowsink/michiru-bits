#!/bin/sh

# super secret, this file should be executable but not readable by anyone else
PASS=REDACTED

# expect the following args:
# - source name
# - dest name <dest email>
# - subject line
# - extra headers
# - message body
SENDNAME="$1"
RECIPIENT="$2"
SUBJECT="$3"
EXTRAHEADS="$4"
BODY="$5"


EMAIL="From: $SENDNAME <michiru@riseup.net>
To: $RECIPIENT
Subject: $SUBJECT
Date: $(date -R)
$EXTRAHEADS

$BODY"

# sendmail: busybox can handle SMTP for us
# -H: connection Helper, openssl can perform TLS for us (or STARTTLS if needed)
# -v: print full ESMTP conversation
# -t: pick up recipients from the body
# -f: sender email
# -amPLAIN: default is LOGIN, but that is deprecated in favour of PLAIN
# -au: username
# -ap: password

echo "$EMAIL" | sendmail -H 'openssl s_client -quiet -tls1_3 -connect mail.riseup.net:465' -v -t -f michiru@riseup.net -amPLAIN -auyellowsink -ap"$PASS"
