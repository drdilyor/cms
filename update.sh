#!/usr/bin/env bash
git pull
killall -r '^cms[A-Z]'
echo cms | sudo -S python3 prerequisites.py install
nohup cmsResourceService -a 3 &
