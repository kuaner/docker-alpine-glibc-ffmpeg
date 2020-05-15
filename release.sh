#!/bin/bash

REPO=d.autops.xyz

VER=3.11

docker build -t $REPO/base:$VER .

docker push $REPO/base:$VER