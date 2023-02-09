echo "##############################"
echo "### create namespace       ###"
echo "##############################"
kubectl create namespace j2lab
kubectl config set-context --current --namespace j2lab

cho "##############################"
echo "### install postgresql-ha  ###"
echo "##############################"
helm install postgresql-ha charts/postgresql-ha
sleep 60
# kubectl port-forward --namespace j2lab svc/postgresql-ha-pgpool 5432:5432
# psql -h 127.0.0.1 -p 5432 -U j2lab -d postgres
#   CREATE DATABASE airflow OWNER j2lab ENCODING 'utf-8';
#   \q

echo "##############################"
echo "### install airflow        ###"
echo "##############################"
helm install airflow charts/airflow
sleep 60
# kubectl port-forward svc/airflow-webserver 8080:8080 --namespace j2lab
# Visit http://localhost:8080
#   user : j2lab

echo "##############################"
echo "### install kafka/zookeeper ###"
echo "##############################"
helm install zookeeper charts/zookeeper
sleep 60
helm install kafka charts/kafka
sleep 60

echo "##############################"
echo "### install kafdrop        ###"
echo "##############################"
helm install kafdrop charts/kafdrop
sleep 60
# Visit http://node-ip:30900

# echo "##############################"
# echo "### install spark          ###"
# echo "##############################"
# helm install spark charts/spark
# sleep 60
# kubectl port-forward --namespace j2lab svc/spark-master-svc 8080:80
# Visit http://localhost:8080

echo "##############################"
echo "### install vscode         ###"
echo "##############################"
helm install code-server charts/code-server
# sleep 60
# kubectl port-forward --namespace j2lab service/code-server 8080:http
# echo $(kubectl get secret --namespace j2lab code-server -o jsonpath="{.data.password}" | base64 --decode)
# Visit http://localhost:8080

echo "##############################"
echo "### Done                   ###"
echo "##############################"
