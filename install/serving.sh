#!/bin/bash

kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.9.2/serving-crds.yaml
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.9.2/serving-core.yaml

kubectl apply -f https://github.com/knative/net-kourier/releases/download/knative-v1.9.2/kourier.yaml
kubectl patch configmap/config-network \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"ingress-class":"kourier.ingress.networking.knative.dev"}}'

sleep 10

kubectl get pods -n knative-serving
kubectl patch configmap/config-domain \
      --namespace knative-serving \
      --type merge \
      --patch '{"data":{"no-domain.com":""}}'

