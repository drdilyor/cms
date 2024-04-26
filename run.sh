#!/usr/bin/bash
export TZ=Asia/Tashkent

if [[ $(hostname) == vmcms ]]; then
    contest=3
    taskset -c 0 cmsContestWebServer 0 -c $contest &
    taskset -c 0 cmsAdminWebServer 0 -c $contest &

    taskset -c 0 cmsScoringService 0 -c $contest &
    taskset -c 0 cmsEvaluationService 0 -c $contest &
    taskset -c 0 cmsProxyWebServer 0 -c $contest &

    taskset -c 1 cmsWorker 0 &
    taskset -c 2 cmsWorker 1 &
    taskset -c 3 cmsWorker 2 &

    taskset -c 0 cmsLogService 0 &
    taskset -c 0 cmsResourceService 0
elif [[ $(hostname) == ranking ]]; then
    cmsRankingWebServer
else
    echo "error: run.sh: unrecognized hostname"
fi
