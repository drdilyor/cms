#!/usr/bin/env bash
vms=(
     123.123.54.76
)

git add .
git commit -m "update"
git push

for ip in ${vms[@]}; do
    echo root@$ip
    ssh root@$ip -t \
        'sudo -i -u cmsuser bash <<< "cd ~/cms && git pull && ./update.sh"'
done
