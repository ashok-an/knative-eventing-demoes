#!/bin/bash

ns="ping-src-demo"

echo "Preparing env ..."
kubectl create ns $ns
kubectl create sa ${ns}-sa -n $ns

export sink="event-display"
export source="ping-events"

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
kn source ping create ${source} \
  --namespace ${ns} \
  --schedule "* * * * *" \
  --data '{"message": "lorem ipsum ...", "key": 12345 }' \
  --sink http://${sink}.${ns}.svc.cluster.local

sleep 10
echo
kubectl get pods -n ${ns}

echo "
To test run,
kubectl logs -l app=event-display -n ping-src-demo"

