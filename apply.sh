#!/bin/bash

# 设置环境变量
source ./env.sh

envsubst < pds/sts.yaml | kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 apply -f -
envsubst < pds/svc.yaml | kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 apply -f -
envsubst < pds/ingress.yaml | kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 apply -f -

envsubst < plc/sts.yaml | kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 apply -f -
envsubst < plc/svc.yaml | kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 apply -f -
envsubst < plc/ingress.yaml | kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 apply -f -

envsubst < bsky/sts.yaml | kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 apply -f -
envsubst < bsky/svc.yaml | kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 apply -f -
envsubst < bsky/ingress.yaml | kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 apply -f -

envsubst < post_cache/sts.yaml | kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 apply -f -
envsubst < post_cache/svc.yaml | kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 apply -f -
envsubst < post_cache/ingress.yaml | kubectl --kubeconfig ~/.kube/xiangjiandao-ack-cluster.yaml -n web5 apply -f -
