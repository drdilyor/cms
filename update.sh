#!/usr/bin/env bash
git pull
killall -r '^cms[A-Z]'
echo "setup..."
sudo python3 setup.py install || exit 1
echo "prereq..."
sudo python3 prerequisites.py --yes --cmsuser=cmsuser install || exit 1
echo "nohup..."
nohup cmsResourceService -a 3 &
