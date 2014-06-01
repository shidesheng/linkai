#!/bin/bash
# Written by Mac@ibw.cn
LOCAL="/home/ibw"

export LANG=zh_CN.UTF-8

cat <<EOF >$LOCAL/log/$(date +%F)check21.txt

亲爱的Session、Access大叔:
我现在美利坚一切顺利！
另外，有件事要告诉你们。
有一些临开网站已经开通超过21天了，请密切关注一下。
以下是这些网站的信息：
----------------------------------------------------------------

EOF


cat $LOCAL/hosts.txt |while read LINE; do
DOMAIN=$(echo $LINE | awk '{print $2}')
CF=$(cat $LOCAL/log/linkai.log |grep "$DOMAIN" | awk '{print $6}'|uniq)
FDAY=$(ls -la $CF --time-style '+%Y%m%d'| awk '{print $6}')
DDAY=$(ls -la $CF --time-style '+%F'| awk '{print $6}')
ODAY=$( date +%Y%m%d -d "21 days ago" )
TODAY=$(date +%Y%m%d)
DAYS=$((($(date -d $TODAY +%s) - $(date -d $FDAY +%s) + 43200) / 86400))
if [ $ODAY -ge $FDAY ];then
echo $DOMAIN 临开于 $DDAY 距今超过 $DAYS 天>>$LOCAL/log/$(date +%F)check21.txt
fi
done
N1=$(cat $LOCAL/log/$(date +%F)check21.txt |wc -l)
SUM=$[$N1 - 12]
echo "---------------总共有 $SUM 个域名需要检查哦---------------" >>$LOCAL/log/$(date +%F)check21.txt
cat <<EOF >>$LOCAL/log/$(date +%F)check21.txt

----------------------------------------------------------------
祝大叔您玩的开心！工作顺利！我在美利坚等你们！

EOF
mail -s "临开网站过期检查报告" mac@ibw.cn session@ibw.cn access@ibw.cn< $LOCAL/log/$(date +%F)check21.txt
