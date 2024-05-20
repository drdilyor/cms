Contest Management System
=========================

Homepage: <http://cms-dev.github.io/>

When cloning the repo pass the `--recursive` argument to `git clone`.

- `Dockerfile` - to easily build a docker image, based on ubuntu 20.04
- `run.sh` - startup script
- `download.sh` - to install cms for the first time, if you are not using docker image. Run it without cloning the repo first
- `update.sh` - to build, install and run cms, if you are not using docker image
- `deploy.sh` - to ssh into each vm, pull the updates and run `update.sh`

Configuring cgroups
-------------------

If you are not running ubuntu 20.04, but later version like 22.04 (or other
distros, Worker will give errors about 'no such directory'), then you should
turn on the following kernel parameters:

```
systemd.unified_cgroup_hierarchy=0
```

Additionally, to make sure other processes don't run on the same core as worker,
add the CPUs used by worker to the following kernel param:

```
isolcpus=1,2,3
```

The format is the same as the one used by taskset --cpu-list (see `man taskset`).
Make sure to isolate the hyperthreaded virtual cpu as well.

Edit `run.sh` and change the cores in which the services should run. In this file
you should add the logic of which services to start depending on the hostname.

Running docker image
--------------------
Building:
```
docker build -t cms .
```
First configure database and run these to get into the container.
You might have to add `--net host` option.
```
docker run --rm -it cms bash
```

Then:
```
cmsInitDB
cmsAddAdmin username -p password
```

Then finally start the services and add a new contest at http://localhost:8889 :
```
docker run --net host --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup --name cms --rm -it cms ./run.sh
```

After adding the contest, restart. To remove the container:
```
docker rm cms -f
```

