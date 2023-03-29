#!/bin/bash
kubectl apply -f .
sleep 10
kn sources list -n kafka-ns
