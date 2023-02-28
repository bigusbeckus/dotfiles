#!/bin/sh

# Install fedora specific packages

sudo dnf groupinstall 'Development Tools' -y
sudo dnf install \
	gcc-c++ \
	patch \
	pkgconfig \
	procps-ng \
	python3-virtualenv \
	glibc-devel \
	-y
