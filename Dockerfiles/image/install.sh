#!/bin/bash
set -e
source /build/buildconfig
set -x

#/build/enable_repos.sh
#/build/prepare.sh
#/build/pups.sh
#/build/utilities.sh

awk -F = '/=1/ {print $1}' /build/buildconfig | while read f; do . /build/$f.sh; done

/build/finalize.sh
