https://knative.dev/docs/eventing/brokers/

[kn event] -> [broker-one] --> [trigger-one] --- [ all ] -> [sink-default] 
                           +-> [trigger-one-a] - [ type=a.foo.bar ] -> [sink-a]
                           +-> [trigger-one-b] - [ type=b.foo.bar ] -> [sink-b]
