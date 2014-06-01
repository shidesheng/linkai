LOCAL="/home/ibw"
cat $LOCAL/domains.txt |while read LINE; do
DOMAIN=$(echo $LINE | awk '{print $2}')
if  [ "" = "$DOMAIN" ];then
echo "EMPTY LINE!!!"
else
CF=$(cat $LOCAL/log/linkai.log |grep "$DOMAIN".conf | awk '{print $6}'|uniq)
rm -rf $CF
sed -i "/$LINE/d" /etc/hosts
sed -i "/$LINE/d" $LOCAL/hosts.txt
echo "$DOMAIN is remove from $CF"
echo $(date +%F" "%T) $DOMAIN is removed from $CF>>$LOCAL/remove.log
fi
done
cp $LOCAL/hosts.txt  /usr/share/nginx/html/

