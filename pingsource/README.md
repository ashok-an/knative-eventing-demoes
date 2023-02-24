```sh
> ./example.sh
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
