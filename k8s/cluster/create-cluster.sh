#!/usr/bin/env bash

minikube --driver docker \
    --nodes 1 \
    --cpus=no-limit --memory=no-limit \
    --kubernetes-version=v1.30.0-rc.2 \
    --container-runtime=docker \
    --profile=wordpress \
    start


minikube profile wordpress


