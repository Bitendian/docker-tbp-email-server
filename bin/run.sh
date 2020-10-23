#!/bin/bash

postconf -e myhostname="$POSTFIX_MYHOSTNAME" \
	          mydestination="$POSTFIX_MYDESTINATION" \
	          mydomain="$POSTFIX_MYDOMAIN"

sed -i 's|unix  -       -       y       -       -       smtp|unix  -       -       n       -       -       smtp|' /etc/postfix/master.cf

postfix start-fg

exec "$@"
