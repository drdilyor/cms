#!/usr/bin/env bash
if [ -z $SECOND_RUN ]; then
    git pull
    export SECOND_RUN=1
    exec ./update.sh "$@"
else
    killall -r '^cms[A-Z]'
    sudo python3 setup.py install || exit 1
    sudo python3 prerequisites.py --yes --cmsuser=cmsuser install || exit 1
    nohup cmsResourceService -a 3 &
    echo "after nohup"
fi
