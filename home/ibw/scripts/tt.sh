N1=$(cat /home/ibw/log/$(date +%F)check21.txt |wc -l)
SUM=$[$N1 - 12]
echo $SUM
FDAY="20130910"
TODAY=$(date +%Y%m%d)
DAYS=$((($(date -d $TODAY +%s) - $(date -d $FDAY +%s) + 43200) / 86400))
echo $DAYS
