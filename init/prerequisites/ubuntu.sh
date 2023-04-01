#!/bin/bash
set -euo pipefail

# Install ubuntu-specific packages
sudo apt install \
	build-essential \
	doxygen \
	g++ \
	libtool-bin \
	pkg-config \
	procps \
	python3-venv \
	binutils \
	-y
