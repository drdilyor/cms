#!/usr/bin/env bash
apt-get update || exit 1
apt-get install -y \
    build-essential \
    cgroup-lite \
    cppreference-doc-en-html \
    git \
    libcap-dev \
    libcups2-dev \
    libffi-dev \
    libpq-dev \
    libyaml-dev \
    postgresql-client \
    python3-pip \
    python3.8 \
    python3.8-dev \
    sudo \
    vim \
    wait-for-it \
    zip || exit 1

useradd -ms /bin/bash cmsuser && usermod -aG sudo cmsuser
LINE='%sudo ALL=(ALL) NOPASSWD:ALL'
grep -qF "$LINE" /etc/sudoers || echo "$LINE" >> /etc/sudoers

sudo -i -u cmsuser bash << END_CMSUSER
cd ~

cat << END > .netrc
machine github.com
login drdilyor
password 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
END
chmod 700 .netrc

git clone https://github.com/drdilyor/cms || exit 1
cd cms
sudo pip3 install -r requirements.txt || exit 1
sudo python3 setup.py install || exit 1
exec ./update.sh
END_CMSUSER
