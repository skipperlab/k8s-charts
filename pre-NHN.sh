echo "##############################"
echo "### creat csi-ssd and default ###"
echo "##############################"

cat <<EOF | kubectl apply -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: csi-ssd
provisioner: cinder.csi.openstack.org
parameters:
  type: General SSD
reclaimPolicy: Delete
allowVolumeExpansion: true
volumeBindingMode: WaitForFirstConsumer
---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: csi-hdd
provisioner: cinder.csi.openstack.org
parameters:
  type: General HDD
reclaimPolicy: Delete
allowVolumeExpansion: true
volumeBindingMode: WaitForFirstConsumer
EOF
kubectl patch storageclass csi-ssd -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

echo "##############################"
echo "### install nfs-client     ###"
echo "##############################"
# service activate NAS

helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
 --set nfs.server=192.168.0.39 \
 --set nfs.path=/opt/share
kubectl patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

