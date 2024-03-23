#!/bin/bash -eux

# Change work dir
cd $(dirname $0)/../
PROJECT_ROOT=`pwd`
export SCRIPTS=$PROJECT_ROOT/scripts
export APP_VERSION=`cat .app-version`
chmod +x ./env
source ./env

envsubst < BariPort/GoogleService-Info.plist.template > BariPort/GoogleService-Info.plist

ruby ./script/generate_client_keys.rb ${HOST_URL}
xcodegen generate
