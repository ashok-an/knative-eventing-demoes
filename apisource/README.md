```sh
> ./example.sh
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
