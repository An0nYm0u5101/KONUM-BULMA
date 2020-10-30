#!/bin/bash
menu () {
kontrol1=$(ps aux |grep "bash $k_ad.sh" |grep -v grep |grep -v index |awk '{print $2}' |wc -l)
if [[ $kontrol1 -gt 0 ]];then
	for no in `seq 1 $kontrol1`;do
		PID=$(ps aux |grep "bash $k_ad.sh" |grep -v grep |grep -v index |awk '{print $2}' |sed -n $no\p)
		kill -9 $PID
	done
fi
}

k_ad=$(sed -n 1p README.md)

while :
do
	kontrol1=$(ps aux |grep "bash $k_ad.sh" |grep -v grep |grep -v index |awk '{print $2}' |wc -l)
	if [[ $kontrol1 -gt 0 ]];then
		menu
	else
		break
	fi
done
