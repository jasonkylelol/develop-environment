#!/bin/bash

image=develop-env:cuda12.2.2-cudnn8-devel-ubuntu22.04

docker run -d -it --rm --cpus 16 -m 32G --gpus all --privileged --ipc host -h dev --name develop-env-do-not-kill \
	-p 32208:22 -p 38060:8060 -p 38061:8061\
	-v /data/lm/runtime/cache:/root/.cache \
	-v /data/lm/runtime/vscode-server:/root/.vscode-server \
	-v /data/lm/runtime/miniconda3/envs:/root/miniconda3/envs \
	-v /data/lm/runtime/nltk_data:/root/nltk_data \
	-v /data/lm/runtime/ssh:/root/.ssh \
	-v /data/lm/apulis:/root/apulis \
	-v /data/lm/github:/root/github \
	-v /data/lm/huggingface/models:/root/huggingface/models \
	$image