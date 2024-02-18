#!/usr/bin/env bash
killall -r '^cms[A-Z]'
sudo python3 setup.py install || exit 1
sudo python3 prerequisites.py --yes --cmsuser=cmsuser install || exit 1
nohup cmsResourceService -a 4 & disown
sleep 0.5s
