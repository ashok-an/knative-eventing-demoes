#!/bin/bash

ns="api-src-demo"

echo "Preparing env ..."
kubectl create ns $ns
kubectl create sa ${ns}-sa -n $ns

echo "Using namespace:${ns}"
cat <<-EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: ${ns}-role
  namespace: ${ns}
rules:
  - apiGroups: [""]
    resources: ["events"]
    verbs: ["get", "list", "watch"]

---
# warning: ClusterRole is generally not required, only if there are errors about
# warning: insufficient permissions
# warning: not to be used in production scenarios
#
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole 
metadata:
  name: ${ns}-cluster-role
  namespace: ${ns}
rules:
  - apiGroups: [""]
    resources: [""]
    verbs: ["get", "list", "watch"]

---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: ${ns}-role-binding
  namespace: ${ns}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: ${ns}-role
subjects:
- kind: ServiceAccount
  name: ${ns}-sa
  namespace: ${ns}

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding 
metadata:
  name: ${ns}-cluster-role-binding
  namespace: ${ns}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: ${ns}-cluster-role
subjects:
- kind: ServiceAccount
  name: ${ns}-sa
  namespace: ${ns}

EOF

export sink="event-display"
export source="api-events"

echo "Creating a sink ..."
cat <<-EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: event-display-dep
  namespace: ${ns}
spec:
  replicas: 1
  selector:
    matchLabels: &labels
      app: ${sink}
  template:
    metadata:
      labels: *labels
    spec:
      containers:
        - name: ${sink}
          image: gcr.io/knative-releases/knative.dev/eventing/cmd/event_display

---

kind: Service
apiVersion: v1
metadata:
  name: ${sink}
  namespace: ${ns}
spec:
  selector:
    app: ${sink}
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
EOF

echo "Creating source ..."
kn source apiserver create ${source} \
  --namespace ${ns} \
  --mode "Resource" \
  --resource "Event:v1" \
  --service-account ${ns}-sa \
  --sink http://${sink}.${ns}.svc.cluster.local

echo
sleep 10

echo "Running tests ..."
kubectl get pods -n ${ns}
kubectl run testpod --image=nginx --restart=Never -n ${ns}
kubectl delete pod/testpod -n ${ns} --force
kubectl logs -l app=event-display -n ${ns} --tail=100 | egrep -i "\"message\"|kind\"|name\"|namespace\"|operation\""


