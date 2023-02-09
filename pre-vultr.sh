echo "##############################"
echo "### set default sc         ###"
echo "##############################"
# - vultr.com minimum SSD size: 10G
kubectl patch sc vultr-block-storage-hdd -p '{"metadata": {"annotations": {"storageclass.kubernetes.io/is-default-class": "false"}}}'
kubectl patch sc vultr-block-storage -p '{"metadata": {"annotations": {"storageclass.kubernetes.io/is-default-class": "true"}}}'

echo "##############################"
echo "### install nfs-client     ###"
echo "##############################"
# sudo apt-get install nfs-kernel-server nfs-common
# mkdir /opt/share
# chown nobody:nogroup /opt/share
# chmod 755 /opt/share
# cat <<EOF > /etc/exports
# /opt/share * (rw,sync,no_subtree_check)
# EOF
# exportfs -a
# service nfs-kernel-server restart

# helm pull https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/ -d .

helm install nfs-subdir-external-provisioner charts/nfs-subdir-external-provisioner
# kubectl patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

