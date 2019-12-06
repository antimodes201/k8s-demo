#!/bin/bash
# Script to help automate a basic kubernetes deployment

wget https://raw.githubusercontent.com/antimodes201/k8s-demo/master/section1.sh
wget https://raw.githubusercontent.com/antimodes201/k8s-demo/master/section2.sh

currentDir=`pwd`

printf "The scripts are designed to provide a framework to automate Kubernetes cluster deployments.
You will need to edit the network segments to work in your environment.  

If you attempt to run them as is they will deploy under T3stn3t's network layout and likely wont work for you.
We cannot be held responsible if you failed to listen and cause an issue in your environment.

Scripts need to be run in two parts.  

Section 1
	Removes existing docker install
	Disables swap
	Reboots
	
	run: ${currentDir}\section1.sh

Section 2
	Installs Docker
	Installs Kubernetes
	Installs MetaLB
	Installs Helm
	
	run: ${currentDir}\section2.sh [CIDR]
	default subnet used is 10.244.0.0/16\n"
