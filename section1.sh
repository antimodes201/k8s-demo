#!/bin/bash
# Section 1

# remove docker installed with ubuntu
snap remove docker

# disable swap
swapoff -a

# reboot
reboot
