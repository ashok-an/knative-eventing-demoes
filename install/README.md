# Steps
##### Install knative eventing
```sh
> ./eventing.sh
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

---

##### Install kafka in the cluster
```sh
> ./kafka-cluster.sh
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

---

##### Install kafka-broker and related entities
```sh
> ./kafka-broker.sh
...
wait and check

kafka-broker-dispatcher-68b8d895bd-ddp9m   0/1     ContainerCreating   0          11s
kafka-broker-receiver-6fc8ddb76f-v9bcn     0/1     ContainerCreating   0          11s
kafka-channel-dispatcher-ddc768ff-7wcp9    0/1     ContainerCreating   0          13s
kafka-channel-receiver-597dfd8466-4b46c    0/1     ContainerCreating   0          13s
kafka-controller-6598bf554-nzfgv           0/1     ContainerCreating   0          15s
kafka-sink-receiver-5697c56cb9-plk6c       0/1     ContainerCreating   0          10s
kafka-webhook-eventing-5bc696f758-f7kfr    0/1     ContainerCreating   0          15s
``` 
