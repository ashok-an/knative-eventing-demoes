# Copied and modified from https://github.com/knative/docs/tree/main/code-samples/eventing/helloworld/helloworld-python#hello-world---python

```sh
> ./example.sh
>>> Applying yamls ...
namespace/knative-demo unchanged
broker.eventing.knative.dev/default unchanged
deployment.apps/ce-python unchanged
service/ce-python unchanged
trigger.eventing.knative.dev/ce-python unchanged
deployment.apps/event-display unchanged
service/event-display unchanged
trigger.eventing.knative.dev/event-display unchanged

>>> Pod status ...
NAME                             READY   STATUS    RESTARTS   AGE
ce-python-768dd48d9-w9bbx        1/1     Running   0          9m48s
event-display-7b5f9f878f-7bcjw   1/1     Running   0          62m
Forwarding from 0.0.0.0:8080 -> 8080

>>> Waiting for 20 sec
>>> Sending: test message - sent at Fri Feb 24 21:07:17 IST 2023 ...
Note: Unnecessary use of -X or --request, POST is already inferred.
*   Trying 127.0.0.1:8080...
* Connected to localhost (127.0.0.1) port 8080 (#0)
> POST /knative-demo/default HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/7.86.0
> Accept: */*
> Ce-Id: abcd-1234-19652-14058
> Ce-specversion: 0.3
> Ce-Type: dev.knative.events.demo01
> Ce-Source: ashoka007/knative-events/demo01
> Content-Type: application/json
> Content-Length: 62
>Handling connection for 8080

* Mark bundle as not supporting multiuse
< HTTP/1.1 202 Accepted
< Allow: POST, OPTIONS
< Date: Fri, 24 Feb 2023 15:37:17 GMT
< Content-Length: 0
<
* Connection #0 to host localhost left intact

>>> Logs from event-display:
  id: c3d72424-3162-45b8-abe4-783718a99939
  datacontenttype: application/json
Extensions,
  knativearrivaltime: 2023-02-24T15:37:19.776520968Z
Data,
  {
  "fake.email": "ihoffman@example.net",
  "fake.name": "Rachel Robinson",
  "fake.url": "http://www.richardson-sullivan.net/",
  "input.msg": "b'{\\n  \"fake.email\": \"christopherjoseph@example.net\",\\n  \"fake.name\": \"Timothy Wise\",\\n  \"fake.url\": \"https://meyers-robbins.com/\",\\n  \"input.msg\": \"b\\'{\\\\\\\\n  \\\\\"fake.email\\\\\": \\\\\"aaron97@example.org\\\\\",\\\\\\\\n  \\\\\"fake.name\\\\\": \\\\\"Monica Cowan\\\\\",\\\\\\\\n  \\\\\"fake.url\\\\\": \\\\\"https://www.anderson.info/\\\\\",\\\\\\\\n  \\\\\"input.msg\\\\\": \\\\\"b\\\\\\\\\\'{\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n  \\\\\\\\\\\\\\\\\\\\\"fake.email\\\\\\\\\\\\\\\\\\\\\": \\\\\\\\\\\\\\\\\\\\\"hhancock@example.org\\\\\\\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n  \\\\\\\\\\\\\\\\\\\\\"fake.name\\\\\\\\\\\\\\\\\\\\\": \\\\\\\\\\\\\\\\\\\\\"Kendra Reynolds\\\\\\\\\\\\\\\\\\\\\",\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n  \\\\\\\\\\\\\\\\\\\\\"fake.url\\\\\\\\\\\\\\\\\\\\\": \\\\\\\\\\\\\\\\\\\\\"https://alexander.com/\\\\\\\\\\\\\\\\
./example.sh: line 37: 20173 Terminated: 15          kubectl port-forward -n knative-eventing svc/broker-ingress --address=0.0.0.0 8080:80

```
