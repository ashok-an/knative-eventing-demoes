#!/bin/bash

ns="simple-sequence-ns"

kubectl create ns ${ns}
kubectl apply -f . -n ${ns}
sleep 10
echo "Run: kubectl logs -n ${ns} -l app=event-display-00001"
