# knative-eventing-demoes
Example demoes for knative

Inspired by https://github.com/matzew/knative-broker-box

# Steps
1. Install knative eventing
```sh
> ./01-install-eventing.sh
...

wait and check

NAME                                   READY   STATUS    RESTARTS   AGE
eventing-controller-579b79f84d-k5bnc   1/1     Running   0          65s
eventing-webhook-d758cd958-lb7lg       1/1     Running   0          65s
imc-controller-65cc5967b7-mtqkg        1/1     Running   0          63s
imc-dispatcher-7cfbb76866-t76pv        1/1     Running   0          63s
mt-broker-controller-85d688f47-7qrp9   1/1     Running   0          61s
mt-broker-filter-559869b768-nnht6      1/1     Running   0          61s
mt-broker-ingress-795f6cd64c-b2fkp     1/1     Running   0          61s
```

2. API server event source
```sh
> ./02-apiserversource.sh
...
NAME                                                              READY   STATUS    RESTARTS   AGE
apiserversource-api-events-54651155-0d05-49cd-a041-0388a56rd84t   1/1     Running   0          106s
event-display-dep-54c498f975-2555g                                1/1     Running   0          107s

To test, run
- kubectl run testpod --image=nginx --restart=Never -n api-src-demo
- kubectl delete pod/testpod -n api-src-demo
- kubectl logs -l app=event-display -n api-src-demo

# Check the logs
> kubectl logs -l app=event-display -n api-src-demo --tail=15
      ],
      "name": "testpod.17467ec2dae18745",
      "namespace": "api-src-demo",
      "resourceVersion": "3784",
      "uid": "65030fe2-2bb8-49ca-a5b5-4f4376ffa7f5"
    },
    "reason": "Killing",
    "reportingComponent": "",
    "reportingInstance": "",
    "source": {
      "component": "kubelet",
      "host": "macbook-worker2"
    },
    "type": "Normal"
  }
```

3. Ping source - for crontab related usecases
```sh
> ./03-pingsource.sh
...
NAME                                 READY   STATUS    RESTARTS   AGE
event-display-dep-54c498f975-dmjtw   1/1     Running   0          108s

To test run,
kubectl logs -l app=event-display -n ping-src-demo

> kubectl logs -l app=event-display -n ping-src-demo
  {"message": "lorem ipsum ...", "key": 12345 }
☁️  cloudevents.Event
Context Attributes,
  specversion: 1.0
  type: dev.knative.sources.ping
  source: /apis/v1/namespaces/ping-src-demo/pingsources/ping-events
  id: f29f0cbc-dcef-4361-b68c-7db2275b158a
  time: 2023-02-23T15:55:00.082689754Z
Data,
  {"message": "lorem ipsum ...", "key": 12345 }
```

4. Install kafka in the cluster
```sh
> ./04-install-kafka.sh
Credit:
Credit: Copied from https://github.com/matzew/knative-broker-box/blob/main/01-strimzi.sh
Credit:
Using Strimzi Version:                  0.33.0
Strimzi install
...

# Verfiy
> kubectl get pod -n kafka
NAME                                        READY   STATUS    RESTARTS   AGE
my-cluster-kafka-0                          1/1     Running   0          8m52s
my-cluster-zookeeper-0                      1/1     Running   0          21m
strimzi-cluster-operator-6b47f54c84-qt7qf   1/1     Running   0          31m
```

5. 
