#!/bin/bash

version="v1.9.1"
echo
echo "Creating kafka knative-eventing resources "
kubectl apply -f https://github.com/knative-sandbox/eventing-kafka-broker/releases/download/knative-${version}/eventing-kafka-controller.yaml

kubectl apply -f https://github.com/knative-sandbox/eventing-kafka-broker/releases/download/knative-${version}/eventing-kafka-channel.yaml
kubectl apply -f https://github.com/knative-sandbox/eventing-kafka-broker/releases/download/knative-${version}/eventing-kafka-broker.yaml
kubectl apply -f https://github.com/knative-sandbox/eventing-kafka-broker/releases/download/knative-${version}/eventing-kafka-sink.yaml

echo
echo "wait and check"
echo
sleep 10
kubectl get pods -n knative-eventing | grep kafka
