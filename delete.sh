#!/bin/bash

kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5-dev delete -f pds/
kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5-dev delete -f plc/
kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5-dev delete -f bsky/
kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5-dev delete -f post_cache/

