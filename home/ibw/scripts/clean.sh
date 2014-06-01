#!/bin/bash
# clean.sh - this script clear Expired Nginx configuration files 
# Written by Mac@ibw.cn
LOCAL="/home/ibw"
cat $LOCAL/hosts.txt |while read LINE; do
DOMAIN=$(echo $LINE | awk '{print $2}')
IP=$(host $DOMAIN |grep address| awk '{print $4}')
if [ "$IP" == "98.126.24.130" ];then
echo "$(date +%F" "%T) $DOMAIN is OK " >> $LOCAL/log/clean.log
else
CF=$(cat $LOCAL/log/linkai.log |grep "$DOMAIN" | awk '{print $6}'|uniq)
FDAY=$(ls -la $CF --time-style '+%Y%m%d'| awk '{print $6}')
ODAY=$( date +%Y%m%d -d "10 days ago" )
if [ $ODAY -ge $FDAY ];then
rm -rf $CF
sed -i "/$LINE/d" /etc/hosts
sed -i "/$LINE/d" $LOCAL/hosts.txt
echo "$(date +%F" "%T) $DOMAIN is remove from $CF" >> $LOCAL/log/clean.log
echo $(date +%F" "%T) $DOMAIN resolve to $IP removed from $CF>>$LOCAL/log/removed.log
else
echo "$(date +%F" "%T) $DOMAIN is new add" >> $LOCAL/log/clean.log
fi
fi
done
service nginx restart
cp $LOCAL/log/removed.log  /usr/share/nginx/html/remove.txt
cp $LOCAL/hosts.txt  /usr/share/nginx/html/
