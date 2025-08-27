#!/bin/bash

# sh delete.sh

kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 scale --replicas=0 sts bsky pds plc post_cache
kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 delete pvc --all
kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 scale --replicas=1 sts bsky pds plc post_cache
