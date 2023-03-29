#!/bin/bash

def_image="gcr.io/knative-releases/knative.dev/eventing/cmd/event_display"
appender="gcr.io/knative-releases/knative.dev/eventing/cmd/appender"

# test
kn service create create-tb-ms --image=${appender} --env MESSAGE="...Create TB..." --cluster-local
sleep 1
kn service create run-tests-ms --image=${appender} --env MESSAGE="...Run tests..." --cluster-local
sleep 1
kn service create clean-tb-ms --image=${appender} --env MESSAGE="...Clean TB..." --cluster-local
sleep 1
kubectl create -f sequence.yaml
kubectl create ns kafka-ne
kubectl create -f ksink-test-done.yaml

# alerts
kn service create alert-ms --image ${def_image} --cluster-local
sleep 1

kn service list
kubectl get KafkaSink -n kafka-ns
