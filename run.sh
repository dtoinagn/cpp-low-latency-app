#!/bin/bash
docker build -t cpp-low-latency .

docker run --rm --cpuset-cpus="2,3" cpp-low-latency
# docker run --rm --name cpp-app cpp-low-latency
