#!/bin/bash
# lk - this script create Reverse Proxy configuration files on nginx server
# Written by Mac@ibw.cn
LOCAL="/home/ibw"
mkdir /etc/nginx/linkai$(date +%Y) 2> /dev/null
mkdir /etc/nginx/linkai$(date +%Y)/linkai$(date +%Y-%m) 2> /dev/null
cat $LOCAL/domains.txt |while read LINE; do
DOMAIN=$(echo $LINE | awk '{print $2}')
WAP=$(echo $DOMAIN | awk -F\. '{print $1}')
DMM=$(echo $DOMAIN | awk -F\www. '{print $2}')
HDM=$(cat  /etc/hosts | grep $DOMAIN | awk '{print $2}'| uniq )
if  [ "$HDM" = "$DOMAIN" ];then
echo "$DOMAIN is added before"
else
case "$WAP" in
www)
cp $LOCAL/ng/temp.conf /etc/nginx/linkai$(date +%Y)/linkai$(date +%Y-%m)/$DOMAIN.conf 
sed -i "s/tmp.com/$DMM/g" /etc/nginx/linkai$(date +%Y)/linkai$(date +%Y-%m)/$DOMAIN.conf
;;
wap|sj|m|3g|*)
cp $LOCAL/ng/tmp.conf /etc/nginx/linkai$(date +%Y)/linkai$(date +%Y-%m)/$DOMAIN.conf 
sed -i "s/www.tmp.com/$DOMAIN/g" /etc/nginx/linkai$(date +%Y)/linkai$(date +%Y-%m)/$DOMAIN.conf 
;;
esac
echo $LINE >> /etc/hosts
echo $LINE >> $LOCAL/hosts.txt
echo "$(date +%F" "%T) Adding $DOMAIN to /etc/nginx/linkai$(date +%Y)/linkai$(date +%Y-%m)/$DOMAIN.conf" 
echo $(date +%F" "%T) Adding $DOMAIN to /etc/nginx/linkai$(date +%Y)/linkai$(date +%Y-%m)/$DOMAIN.conf  >>$LOCAL/log/linkai.log 
fi
done
DN=$(cat $LOCAL/domains.txt |wc -l)
echo -e "processing $DN domains \nLog file is '$LOCAL/log/linkai.log'"
service nginx restart
cat /dev/null > $LOCAL/domains.txt
cp $LOCAL/log/linkai.log  /usr/share/nginx/html/linkai.txt
cp $LOCAL/hosts.txt  /usr/share/nginx/html/

