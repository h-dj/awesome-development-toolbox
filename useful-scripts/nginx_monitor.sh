#!/bin/bash
# nginx 自动筛选出访问量过大的ip进行屏避
# 还没验证，先记录

nginx_home=/etc/nginx
log_path=/var/log/nginx
tail -n10000 $log_path/access.log \
      |awk '{print $1,$12}' \
      |grep -i -v -E "google|yahoo|baidu|msnbot|FeedSky|sogou" \
      | grep -v '223.223.198.231' \
      |awk '{print $1}'|sort|uniq -c|sort -rn \
      |awk '{if($1>50)print "deny "$2";"}' >>./blockips.conf

sort ./blockips.conf |uniq -u  >./blockips_new.conf
mv ./blockips.conf ./blockips_old.conf
mv ./blockips_new.conf ./blockips.conf
cat ./blockips.conf
#service nginx  reload