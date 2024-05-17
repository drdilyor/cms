#!/usr/bin/bash
export TZ=Asia/Tashkent

contest=1  # enter the contest id
taskset -c 2 cmsContestWebServer 0 -c $contest &
taskset -c 2 cmsAdminWebServer 0 -c $contest &

taskset -c 2 cmsScoringService 0 -c $contest &
taskset -c 2 cmsEvaluationService 0 -c $contest &
taskset -c 2 cmsProxyService 0 -c $contest &

taskset -c 4 cmsWorker 0 &
taskset -c 6 cmsWorker 1 &
taskset -c 8 cmsWorker 2 &

taskset -c 2 cmsLogService 0 &
taskset -c 2 cmsResourceService 0
