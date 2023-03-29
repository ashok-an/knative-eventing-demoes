#!/bin/bash

webhookUrl="https://webhook.site/4ddea95c-e350-4b6a-9464-ca069b999df4"
alertUrl="https://webhook.site/d5f0f047-11a6-4bfb-baed-1c8ec6711569"

_url="http://173.39.62.80:5000"
buildUrl="${_url}/task/build"
commitUrl="${_url}/task/commit"

kn trigger list -n kafka-ns | awk '{print $1}' | while read t; do
  kn trigger delete $t -n kafka-ns
done

kn trigger create kt-build-start -n kafka-ns --broker kb-build --filter commitstatus=pass --sink ${buildUrl}
sleep 1
kubectl apply -f $(dirname $0)/kt-test-start.yaml
sleep 1
kn trigger create kt-commit-start -n kafka-ns --broker kb-commit --filter teststatus=pass --sink ${commitUrl}

# common notifications
kn trigger create kt-build-all  -n kafka-ns --broker kb-build  --sink ${alertUrl}
kn trigger create kt-test-all   -n kafka-ns --broker kb-test   --sink ${alertUrl}
kn trigger create kt-commit-all -n kafka-ns --broker kb-commit --sink ${alertUrl}

# list
kn trigger list -n kafka-ns
