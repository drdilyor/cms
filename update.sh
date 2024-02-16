#!/usr/bin/env bash
git pull
killall -r '^cms[A-Z]'
sudo python3 setup.py install || exit 1
sudo python3 prerequisites.py --yes --cmsuser=cmsuser install || exit 1
nohup cmsResourceService -a 3 &
