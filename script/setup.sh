#!/bin/bash -eux

# Change work dir
cd $(dirname $0)/../
PROJECT_ROOT=`pwd`
export SCRIPTS=$PROJECT_ROOT/scripts
export APP_VERSION=`cat .app-version`
chmod +x ./env
./env

xcodegen generate
