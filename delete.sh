#!/bin/bash

kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 delete -f pds/
kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 delete -f plc/
kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 delete -f bsky/
kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 delete -f post_cache/

