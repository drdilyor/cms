#!/usr/bin/env bash
vms=(
    209.38.188.115  # cmsvm
    209.38.220.28   # worker-1
)

git add .
git commit -m "update"
git push

for ip in ${vms[@]}; do
    echo root@$ip
    ssh root@$ip <<< '
        sudo -i -u cmsuser bash <<< "cd ~/cms && git pull && ./update.sh"
        echo "done ssh"
        exit
    '
done
