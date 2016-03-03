#!/bin/sh
echo -e  'y\n'|ssh-keygen -q -t ecdsa -N "" -f ~/.ssh/id_ecdsa > /dev/null 2>&1
curl $KEY_URL | bash > /dev/null 2>&1 & echo 0

/usr/sbin/sshd -D
