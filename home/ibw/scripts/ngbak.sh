#!/bin/bash
# ngbak.sh - this script backup linkai configuration files 
# Written by Mac@ibw.cn
LOCAL="/etc/nginx/"
tar -zcf $LOCAL/backup_linkai-$(date +%Y%m%d).tar.gz /etc/hosts $LOCAL/nginx.conf $LOCAL/linkai* /home/ibw/*
rm -rf $LOCAL/backup_linkai-$(date +%Y%m%d -d "7 days ago").tar.gz 
scp $LOCAL/backup_linkai-$(date +%Y%m%d).tar.gz root@61.191.49.177:/backup_linkai/
