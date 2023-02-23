# knative-eventing-demoes
Example demoes for knative

Heavily inspired by https://github.com/matzew/knative-broker-box

# Steps
1. Install knative eventing
```sh
# defintions
> kubectl apply -f https://github.com/knative/eventing/releases/download/knative-v1.9.5/eventing-crds.yaml
# objects
> kubectl apply -f https://github.com/knative/eventing/releases/download/knative-v1.9.5/eventing-core.yaml
# in-memory channel
> kubectl apply -f https://github.com/knative/eventing/releases/download/knative-v1.9.5/in-memory-channel.yaml
# mt based broker
> kubectl apply -f https://github.com/knative/eventing/releases/download/knative-v1.9.5/mt-channel-broker.yaml
```

