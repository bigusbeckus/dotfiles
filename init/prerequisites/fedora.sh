#!/bin/sh

sudo yum groupinstall 'Development Tools'
sudo yum install \
	gcc \
	gcc-c++ \
	make \
	patch \
	pkgconfig \
	procps-ng
