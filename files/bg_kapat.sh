#!/bin/bash
menu () {
echo
echo
kontrol1=$(ps aux |grep "$k_ad" |grep -v grep |grep -v index |awk '{print $2}' |wc -l)
if [[ $kontrol1 -gt 0 ]];then
	for no in `seq 1 $kontrol1`;do
		PID=$(ps aux |grep "$k_ad" |grep -v grep |grep -v index |awk '{print $2}' |sed -n $no\p)
		kill -9 $PID
	done
	echo
	echo
	echo
	printf "\e[32m[✓] \e[33m$b_ad\e[97m ARKAPLANDAN KAPATILDI"
	echo
	echo
	echo
fi
}
k_ad="ngrok"
b_ad="NGROK"
while :
do
	kontrol1=$(ps aux |grep "$k_ad" |grep -v grep |grep -v index |awk '{print $2}' |wc -l)
	if [[ $kontrol1 -gt 0 ]];then
		menu
	else
		echo
		echo
		echo
		printf "\e[32m[*] \e[33m$b_ad\e[97m ARKAPLAN DA ÇALIŞMIYOR"
		echo
		echo
		echo
		break
	fi
done
k_ad='127.0.0.1'
b_ad="PHP"
while :
do
	kontrol1=$(ps aux |grep "$k_ad" |grep -v grep |grep -v index |awk '{print $2}' |wc -l)
	if [[ $kontrol1 -gt 0 ]];then
		menu
	else
		echo
		echo
		echo
		printf "\e[32m[*] \e[33m$b_ad\e[97m ARKAPLAN DA ÇALIŞMIYOR"
		echo
		echo
		echo
		break
	fi
done

