#!/bin/bash

#Allow to run outside of directory
cd `dirname $0`

# change to start meteor in production (https) or development (http) mode
ENVIRONMENT_TYPE=production

export METEOR_SETTINGS=$(cat programs/server/assets/app/config/settings-production.json)

cd /usr/share/meteor/bundle
export ROOT_URL=http://127.0.0.1/html5client
export MONGO_OPLOG_URL=mongodb://127.0.1.1/local
export MONGO_URL=mongodb://127.0.1.1/meteor
export NODE_ENV=$ENVIRONMENT_TYPE 
PORT=3000 /usr/share/node-v8.9.4-linux-x64/bin/node main.js

