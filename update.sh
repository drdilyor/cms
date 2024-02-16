#!/usr/bin/env bash
git pull
killall -r '^cms[A-Z]'
sudo python3 prerequisites.py --yes --cmsuser=cmsuser install
nohup cmsResourceService -a 3 &
