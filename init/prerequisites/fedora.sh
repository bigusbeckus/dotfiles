#!/bin/sh

# Install fedora specific packages

sudo dnf groupinstall 'Development Tools' -y
sudo dnf install \
	gcc \
	gcc-c++ \
	make \
	patch \
	pkgconfig \
	procps-ng \
	python3-virtualenv \
	-y
