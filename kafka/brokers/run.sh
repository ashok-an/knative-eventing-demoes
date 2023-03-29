#!/bin/bash
kubectl apply -f .
sleep 10
kn broker list -n kafka-ns
