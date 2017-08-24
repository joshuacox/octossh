#!/bin/sh

mkdir -p /home/octossh/.ssh
if [ ! -f /home/octossh/.ssh/id_ecdsa.pub ]
  then
    echo -e  'y\n'|ssh-keygen -q -t ecdsa -N "" -f /home/octossh/.ssh/id_ecdsa > /dev/null 2>&1
fi

ssh-keygen -A
curl $KEY_URL|sort|uniq>/home/octossh/.ssh/authorized_keys
chown -R octossh. /home/octossh
chmod 600 /home/octossh/.ssh/authorized_keys
chmod 600 /home/octossh/.ssh

exec /usr/sbin/sshd -D -e "$@"
