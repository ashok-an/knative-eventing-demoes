#!/bin/bash
ns="broker-trigger-ns"
image="gcr.io/knative-releases/knative.dev/eventing/cmd/event_display"

echo "Using namespace:${ns}"
kubectl create ns ${ns}

echo
echo "Creating sinks ..."
for s in "sink-default" "sink-a" "sink-b"; do
  kn service create ${s} --image=${image} --scale=1 --cluster-local --tag @latest=${s} -n ${ns}
done
sleep 2
kn service list -n ${ns}

echo
echo "Creating broker"
kn broker create broker-one -n ${ns}
sleep 2
kn broker list -n ${ns}

echo
echo "Creating triggers"
kn trigger create trigger-one --broker broker-one --sink ksvc:sink-default -n ${ns}
kn trigger create trigger-one-a --broker broker-one --sink ksvc:sink-a --filter type=a.foo.bar  -n ${ns}
kn trigger create trigger-one-b --broker broker-one --sink ksvc:sink-b --filter type=b.foo.bar  -n ${ns}
sleep 2
kn trigger list -n ${ns}

echo
echo "Sending traffic"
for t in "test" "demo" "a.foo.bar" "a.xyz" "b.foo.bar" "b.xyz"; do
  _id=$(uuidgen)
  echo "Send: id=${_id}, type=${t}"
  kn event send \
    --type ${t} \
    --id ${_id} \
    --field event.type=test-event-${t} \
    --field event.data="{'message': 'hello world', 'time': $(date) }" \
    --to Broker:eventing.knative.dev/v1:broker-one -n ${ns}
  sleep 1
done

echo
echo "Checking logs"
for s in "sink-default" "sink-a" "sink-b"; do
  label="app=${s}-00001"
  kubectl logs -l ${label} -n ${ns} --tail=50 | egrep "type\"|data\"" | sed "s/^/${s}: /"
  echo
done
