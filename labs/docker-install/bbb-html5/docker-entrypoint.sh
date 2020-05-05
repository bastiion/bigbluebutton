#!/bin/bash


# change to start meteor in production (https) or development (http) mode
ENVIRONMENT_TYPE=production

export METEOR_SETTINGS=$(cat programs/server/assets/app/config/settings-production.json)

export ROOT_URL=http://127.0.0.1/html5client
export MONGO_OPLOG_URL=mongodb://127.0.1.1/local
export MONGO_URL=mongodb://127.0.1.1/meteor
export NODE_ENV=$ENVIRONMENT_TYPE 
PORT=3000 node main.js

