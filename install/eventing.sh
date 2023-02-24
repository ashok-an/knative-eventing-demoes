#!/bin/bash

version="v1.9.5"
echo
echo "Creating knative-eventing definitions "
kubectl apply -f https://github.com/knative/eventing/releases/download/knative-${version}/eventing-crds.yaml
echo
echo "Creating knative-eventing objects "
kubectl apply -f https://github.com/knative/eventing/releases/download/knative-${version}/eventing-core.yaml
echo
echo "Creating in-memory channel "
kubectl apply -f https://github.com/knative/eventing/releases/download/knative-${version}/in-memory-channel.yaml
echo
echo "Creating mt based broker "
kubectl apply -f https://github.com/knative/eventing/releases/download/knative-${version}/mt-channel-broker.yaml

echo
echo "wait and check"
echo
sleep 5
kubectl get pods -n knative-eventing
