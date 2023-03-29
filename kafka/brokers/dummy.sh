#!/bin/bash

kn broker create kb-build -n kafka-ns
kn broker create kb-test -n kafka-ns
kn broker create kb-commit -n kafka-ns

kn broker list -n kafka-ns
