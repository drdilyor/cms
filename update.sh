#!/usr/bin/env bash
sudo python3 setup.py install || exit 1
sudo python3 prerequisites.py --yes --cmsuser=cmsuser install || exit 1
killall -r '^cms[A-Z]'
nohup cmsResourceService -a 43 & disown
sleep 0.5s
