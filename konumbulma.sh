#!/bin/bash
clear
#################### GÜNCELLEME TARİHİ EKLEME ###################
#
if [[ $1 == güncelle || $1 == güncelleme ]];then
	echo
	echo
	echo
	read -e -p $'\e[32mTARİH GİRİNİZ \e[31m>\e[0m ' tarih
	echo
	echo
	songuncelleme=$(sed -n 35p README.md |tr -d "Güncelleme ")
	sed -ie "s/$songuncelleme/$tarih/g" konumbulma.sh
	songuncelleme2=$(sed -n 35p README.md |tr -d "Güncelleme ")
	sed -ie "s/$songuncelleme2/$tarih/g" README.md
	echo
	echo
	echo
	printf "\e[32m[*]\e[0m TARİH GÜNCELLENDİ "
	echo
	echo
	rm konumbulma.she
	rm README.mde
	exit

fi
#################### OTOMATİK GÜNCEKLEME ####################

guncelleme=$(curl -s "https://github.com/termux-egitim/KONUMBULMA" |grep -o 10.07.2020)
readmi=$(sed -n 35p README.md |tr -d "Güncelleme ")
if [ "$guncelleme" = "$readmi" ];then
	echo
else
	echo
	echo
	echo
	printf "\e[32m[*]\e[0m KONUM BULMA ARACI GÜNCELLENİYOR "
	echo
	echo
	echo
	sleep 2
	cd ..
	if [[ -a konumbulma ]];then
		rm -rf konumbulma
		git clone https://github.com/termux-egitim/konumbulma
		exit
	fi
	if [[ -a KONUMBULNA ]];then
		rm -rf KONUMBULMA
		git clone https://github.com/termux-egitim/konumbulma
		exit
	fi
fi
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
	mv ngrok/ngrok /data/data/com.termux/files/usr/bin
	chmod 777 /data/data/com.termux/files/usr/bin/ngrok
	rm -rf ngrok
	sleep 2
	bash kurulum.sh
fi



#################### BULUNAN KONUM ADRESİ ####################
clear
cd files
bash banner.sh
if [[ -e "eskikonum.txt" ]]; then
	kontrol=$(cat eskikonum.txt |wc -w)
	if [[ $kontrol == 0 ]];then
		echo
	else
		echo
		printf "\e[32m [*] BULUNAN KONUM ADRESİ \e[31m> \e[0m "
		satir=$(cat eskikonum.txt |wc -w)
		sed -n $satir\p eskikonum.txt
	fi
fi


#################### URL BULMA DÖNGÜSÜ ####################

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

#################### MENÜ ####################

menu() {
printf "

[1]  \e[31m──────────[\e[32mBAŞLAT\e[31m]\e[0m

[2]  \e[31m──────────[\e[32mGEÇMİŞ KONUM ADRESLERİ\e[31m]\e[0m

[3]  \e[31m──────────[\e[32mNGROK GÜNCELLE\e[31m]\e[0m

\e[31m[\e[0mCTRL Z\e[31m]  \e[31m─────[\e[32mÇIKIŞ\e[31m]\e[0m
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
	if [[ -a eskikonum.txt ]];then
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
	kontrol=$(cat eskikonum.txt |wc -w)
	if [[ $kontrol == 0 ]];then
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
	read -e -p $'          GEÇMİŞ KONUM ADRESLERİNİ SİLMEK İSTER MİSİNİZ ? \e[32mEVET\e[0m / \e[31mHAYIR \e[0m>> ' sil
	echo
	echo
	echo
	if [[ $sil == e || $sil == evet || $sil == EVET || $sil == E ]];then
		rm eskikonum.txt
		touch eskikonum.txt
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
elif [ $secim == 3 ];then
	echo
	echo
	echo
	printf "\e[32m
	[1]\e[0m NGROK VERSİON 2.2.6\e[32m

	[2]\e[0m NGROK SON SÜRÜM
	"
	echo
	echo
	echo
	read -e -p $'\e[32mSEÇENEK GİRİNİZ \e[31m>\e[0m ' sec
	echo
	echo
	echo
	if [[ $sec == 1 ]];then
		git clone https://github.com/termux-egitim/ngrok
		mv ngrok/ngrok /data/data/com.termux/files/usr/bin
		chmod 777 /data/data/com.termux/files/usr/bin/ngrok
		rm -rf ngrok
		echo
		echo
		echo
		printf "\e[32m[✓] \e[0mNGROK VERSİON 2.2.6 KURULUMU TAMAMLANDI"
		echo
		echo
		echo
		sleep 2
		cd ..
		bash konumbulma.sh
	elif [[ $sec == 2 ]];then
		wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
		unzip ngrok-stable-linux-arm.zip
		rm -rf ngrok-stable-linux-arm.zip
		mv ngrok /data/data/com.termux/files/usr/bin
		chmod 777 /data/data/com.termux/files/usr/bin/ngrok
		echo
		echo
		echo
		printf "\e[32m[✓] \e[0mNGROK SON SÜRÜM KURULUMU TAMAMLANDI"
		echo
		echo
		echo
		sleep 2
		cd ..
		bash konumbulma.sh
	fi
elif [[ $secim == Y || $secim == y ]]; then
	cd ..
	bash konumbulma.sh
elif [[ $secim == d || $secim == D ]]; then
	cd ..
	vim konumbulma.sh
	bash konumbulma.sh
else
	echo
	echo
	echo
	printf "\e[31m[!]\e[0m HATALI SEÇİM \e[31m!!!\e[0m"
	echo
	echo
	echo
	cd ..
	sleep 2
	bash konumbulma.sh
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


