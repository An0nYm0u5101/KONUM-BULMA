#!/bin/bash
clear
cd files
bash banner.sh

if [[ -e "eskikonum.txt" ]]; then
	printf "\e[32m [!] BULUNAN KONUM ADRESİ > \e[0m "
	cat eskikonum.txt
fi
url() {
	while true;
	do
		if [[ -e "konum.txt" ]]; then
			link=$(cat konum.txt)
			xdg-open $link
			rm konum.txt
			exit


		fi
	done


}
menu() {
printf "

[1]  \e[31m──────────[\e[32mBAŞLAT\e[31m]\e[0m

[2]  \e[31m──────────[\e[32mKURULUM YAP\e[31m]\e[0m

[\e[31mX\e[0m]  \e[31m──────────[\e[32mÇIKIŞ\e[31m]\e[0m
"
echo
echo
echo
read -p $'\e[31m────────────────────────[\e[32mKoNuM BuLMa\e[31m]───────►  \e[0m' secim

if [ $secim == 1 ];then
	rm eskikonum.txt
	clear
	echo
	echo
	echo
	read -p $' \e[32mPORT GİRİNİZ\e[31m >> \e[0m' port
	echo
	echo
	echo
	php -S 127.0.0.1:$port & ngrok http $port &
	url
elif [[ $secim == 2 ]];then
	echo
	echo
	echo
	pkg install php -y
	git clone https://github.com/termux-egitim/ngrok
	cd ngrok
	bash kurulum.sh
	echo
	echo
elif [[ $secim == Y || $secim == y ]]; then
	cd ..
	bash konumbulma.sh
elif [[ $secim == d || $secim == D ]]; then
	cd ..
	vim konumbulma.sh
	bash konumbulma.sh
elif [[ $secim == x || $secim == X || $secim == exit || $secim == EXİT ]];then
	echo
	echo
	printf "                         \e[31m [!] ÇIKIŞ YAPILDI"
	echo
	echo
	echo
	echo
	exit
else
	$secim
	menu
fi
}
if [[ $1 == kur ]];then
	pkg install php -y
	git clone https://github.com/termux-egitim/ngrok
	cd ngrok
	bash kurulum.sh
fi
menu


