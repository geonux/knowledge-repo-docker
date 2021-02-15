#!/bin/bash

cd /app/${GIT_REPO}
/user/bin/git pull origin master >> /var/log/cron.log 2>&1 
