#!/bin/sh


if [ ! -f /root/.ssh/id_ecdsa.pub ]
  then
    echo -e  'y\n'|ssh-keygen -q -t ecdsa -N "" -f ~/.ssh/id_ecdsa > /dev/null 2>&1
fi

ssh-keygen -A
curl $KEY_URL|sort|uniq>/root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

exec /usr/sbin/sshd -D -e "$@"
