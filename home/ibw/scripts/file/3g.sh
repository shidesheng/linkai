#!/bin/bash
# lk - this script create Reverse Proxy configuration files on nginx server
# Written by Mac@ibw.cn
LOCAL="/home/ibw"
cat $LOCAL/domains.txt >> /etc/hosts 
mkdir /etc/nginx/linkai$(date +%F) 2> /dev/null
cat $LOCAL/domains.txt | awk  '{print $2}' |while read DOMAIN; do
echo "Now processing $DOMAIN ..."
cp $LOCAL/ng/tmp.conf /etc/nginx/linkai$(date +%F)/$DOMAIN.conf
sed -i "s/www.tmp.com/$DOMAIN/g" /etc/nginx/linkai$(date +%F)/$DOMAIN.conf
echo $(date +%F" "%T) Adding $DOMAIN to /etc/nginx/linkai$(date +%F)/$DOMAIN.conf >>$LOCAL/linkai.log
done
DN=$(cat $LOCAL/domains.txt |wc -l)
echo -e "$DN domains added to '/etc/nginx/linkai$(date +%F)/' \nLog file is '$LOCAL/linkai.log'"
service nginx restart
cat /dev/null > $LOCAL/domains.txt
cp $LOCAL/linkai.log  /usr/share/nginx/html/linkai.txt
