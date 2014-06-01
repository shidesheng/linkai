#!/bin/bash
# edit.sh - this script create "Nginx Reverse Proxy" configuration files 
# Written by Mac@ibw.cn
LOCAL="/home/ibw"
echo "What you want to do?Please answer del or mod." 
read DEL_OR_MOD
case "$DEL_OR_MOD" in
d|del|delete)
echo "Please enter IP DOMAIN you want to delete" 
read LINE
DOMAIN=$(echo $LINE | awk '{print $2}')
CF=$(cat $LOCAL/log/linkai.log |grep "$DOMAIN.conf" | awk '{print $6}'|uniq)
rm -rf $CF
sed -i "/$DOMAIN/d" /etc/hosts
sed -i "/$DOMAIN/d" $LOCAL/hosts.txt
echo "$DOMAIN is removed from $CF"
echo $(date +%F" "%T) $DOMAIN is removed from $CF>>$LOCAL/log/removed.log
;;
m|mo|mod|modify)
echo "Please enter the IP DOMAIN you want to modify."
read LINEM
DOMAIN=$(echo $LINEM | awk '{print $2}')
HLINE=$(cat /etc/hosts |grep $DOMAIN )
sed -i "s/$HLINE/$LINEM/g" /etc/hosts
sed -i "s/$HLINE/$LINEM/g" $LOCAL/hosts.txt
echo "'$HLINE' modify to '$LINEM' OK"
;;
*)
  echo "Sorry, $DEL_OR_MOD not recognized. Enter del or mod."
  exit 1
;;
esac
exit 0
