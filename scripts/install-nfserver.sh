#!/bin/sh
sudo apt-get install nfs-kernel-server nfs-common
mkdir /opt/share
chown nobody:nogroup /opt/share
chmod 755 /opt/share
cat <<EOF > /etc/exports
/opt/share *(rw,sync,no_subtree_check,no_root_squash)
EOF
exportfs -a
service nfs-kernel-server restart
