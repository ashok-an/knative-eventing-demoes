#!/bin/bash

echo ">>> Applying yamls ..."
kubectl apply -f sample-app.yaml
sleep 2

echo
echo ">>> Pod status ..."
kubectl get pods -n knative-demo

pidFile="/tmp/pf.pid.$$"
kubectl port-forward -n knative-eventing svc/broker-ingress --address=0.0.0.0 8080:80 &
echo $!>${pidFile}
sleep 2


echo
echo ">>> Waiting for 20 sec"
sleep 20
message="test message - sent at $(date)"
echo ">>> Sending: ${message} ..."

curl -v "http://localhost:8080/knative-demo/default" \
  -X POST \
  -H "Ce-Id: abcd-1234-${RANDOM}-${RANDOM}" \
  -H "Ce-specversion: 0.3" \
  -H "Ce-Type: dev.knative.events.demo01" \
  -H "Ce-Source: ashoka007/knative-events/demo01" \
  -H "Content-Type: application/json" \
  -d "{'msg': '${message}'}"
sleep 2

echo
echo ">>> Logs from event-display:"
kubectl --namespace knative-demo logs -l app=event-display --tail=10
pkill -F ${pidFile} &>/dev/null
/bin/rm -f ${pidFile}
