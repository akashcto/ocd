#!/bin/bash
set -e
source /build/buildconfig
set -x

apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -f /build/{install,enable_repos,prepare,pups,nginx-passenger,finalize}.sh
rm -f /build/{Dockerfile,insecure_key*}
[ "$final" = "no" ] || rm -rf /build
