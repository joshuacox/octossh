#!/bin/sh
echo -e  'y\n'|ssh-keygen -q -t ecdsa -N "" -f ~/.ssh/id_ecdsa > /dev/null 2>&1
rm  -f /root/.ssh/authorized_keys
#curl $KEY_URL |xargs -n1 -I{} echo '{}'>> /tmp/rootsshauthorized_keys
wget $KEY_URL -O /tmp/rootsshauthorized_keys
cat /tmp/rootsshauthorized_keys|sort|uniq>/tmp/rootsshauthorized_keysuniq
rm /tmp/rootsshauthorized_keys
mv /tmp/rootsshauthorized_keysuniq /root/.ssh/authorized_keys

chmod 600 /root/.ssh/authorized_keys

/usr/sbin/sshd -D
