echo "##############################"
echo "### airflow role add       ###"
echo "##############################"
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  annotations:
    meta.helm.sh/release-name: airflow
    meta.helm.sh/release-namespace: j2lab
  labels:
    app.kubernetes.io/managed-by: Helm
    chart: airflow-1.6.0
    heritage: Helm
    release: airflow
    tier: airflow
  name: airflow-pod-launcher-role
  namespace: j2lab
rules:
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - create
  - list
  - get
  - patch
  - watch
  - delete
- apiGroups:
  - ""
  resources:
  - pods/log
  verbs:
  - get
- apiGroups:
  - ""
  resources:
  - pods/exec
  verbs:
  - create
  - get
- apiGroups:
  - ""
  resources:
  - events
  verbs:
  - list
- apiGroups:
  - policy
  resourceNames:
  - magnum.privileged
  resources:
  - podsecuritypolicies
  verbs:
  - use
EOF
# kubectl get Role
# kubectl describe Role/airflow-pod-launcher-role
# kubectl get RoleBinding
# kubectl describe RoleBinding/airflow-pod-launcher-rolebinding
# kubectl get psp
# kubectl describe psp/magnum.privileged

echo "##############################"
echo "### add spark service account ###"
echo "##############################"
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: spark
  namespace: j2lab
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: j2lab
  name: spark-role
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["*"]
- apiGroups: [""]
  resources: ["services","configmaps"]
  verbs: ["*"]
- apiGroups: ["*"]
  resources: ["persistentvolumeclaims"]
  verbs: ["*"]
- apiGroups:
  - policy
  resourceNames:
  - magnum.privileged
  resources:
  - podsecuritypolicies
  verbs:
  - use
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: spark-role-binding
  namespace: j2lab
subjects:
- kind: ServiceAccount
  name: spark
  namespace: default
roleRef:
  kind: Role
  name: spark-role
  apiGroup: rbac.authorization.k8s.io
EOF