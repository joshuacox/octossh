#!/bin/sh
DATE1=$(date +"%y-%m-%d-%H:%M:%S:%p:%N")
PASSWORD=$(echo $DATE1 | sha256sum)

mkdir -p /home/octossh/.ssh
if [ ! -f /home/octossh/.ssh/id_ecdsa.pub ]
  then
    echo -e  'y\n'|ssh-keygen -q -t ecdsa -N "" -f /home/octossh/.ssh/id_ecdsa > /dev/null 2>&1
fi

ssh-keygen -A
curl $KEY_URL|sort|uniq>/home/octossh/.ssh/authorized_keys
chown -R octossh:octossh /home/octossh
chown -R octossh:octossh /home/octossh
chmod 700 /home/octossh/.ssh
chmod 700 /home/octossh/.ssh/authorized_keys
echo "octossh:$PASSWORD" | chpasswd
passwd -u octossh
chsh octossh -s /bin/ash


exec /usr/sbin/sshd -D -e "$@"
