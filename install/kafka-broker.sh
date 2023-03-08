#!/bin/bash

version="v1.9.2"
echo
echo "Creating kafka knative-eventing resources "
for i in $(seq 1 2); do
  kubectl apply -f https://github.com/knative-sandbox/eventing-kafka-broker/releases/download/knative-${version}/eventing-kafka-controller.yaml
  kubectl apply -f https://github.com/knative-sandbox/eventing-kafka-broker/releases/download/knative-${version}/eventing-kafka-source.yaml
  kubectl apply -f https://github.com/knative-sandbox/eventing-kafka-broker/releases/download/knative-${version}/eventing-kafka-sink.yaml

  kubectl apply -f https://github.com/knative-sandbox/eventing-kafka-broker/releases/download/knative-${version}/eventing-kafka-channel.yaml
  kubectl apply -f https://github.com/knative-sandbox/eventing-kafka-broker/releases/download/knative-${version}/eventing-kafka-broker.yaml
  sleep 10
done | grep -v unchanged

echo
echo "wait and check"
echo
sleep 10
kubectl get deployments -n knative-eventing | grep kafka
kn sources list -n knative-eventing
kubectl get KafkaSource -n knative-eventing
