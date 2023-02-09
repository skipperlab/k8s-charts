helm uninstall code-server charts/code-server
helm uninstall kafdrop charts/kafdrop
helm uninstall kafka charts/kafka
helm uninstall zookeeper charts/zookeeper
helm uninstall airflow charts/airflow
helm uninstall postgresql-ha charts/postgresql-ha
helm uninstall nfs-subdir-external-provisioner

helm uninstall spark charts/spark
kubectl delete namespace j2lab
echo "##############################"
echo "### Done                   ###"
echo "##############################"