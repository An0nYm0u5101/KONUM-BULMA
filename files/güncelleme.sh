#!/bin/bash
clear
cd ..
kucukad=$(sed -n 1p README.md)
buyukad=$(sed -n 2p README.md)
#################### GÜNCELLEME TARİHİ EKLEME ####################
if [[ $1 == güncelle ]];then
	echo
	echo
	echo
	printf "\e[33mSON GÜNCELLEME TARİHİ \e[31m>\e[0m $(sed -n 3p README.md |tr -d \"Güncelleme\")"
	echo
	echo
	echo
	history -s $(date +%d.%m.%G)
	#history -s $(sed -n 3p README.md |tr -d "Güncelleme")
	read -e -p $'\e[32mTARİH GİRİNİZ \e[31m>\e[0m ' tarih
	echo
	echo
	songuncelleme=$(sed -n 3p README.md |tr -d "Güncelleme ")
	sed -ie "s/$songuncelleme/$tarih/g" $kucukad.sh
	songuncelleme2=$(sed -n 3p README.md |tr -d "Güncelleme ")
	sed -ie "s/$songuncelleme2/$tarih/g" README.md
	echo
	echo
	echo
	printf "\e[32m[*]\e[0m TARİH GÜNCELLENDİ "
	echo
	echo
	if [[ -a $kucukad.she ]];then
		rm $kucukad.she
	fi
	if [[ -a README.mde ]];then
		rm README.mde
	fi
	exit

fi
#################### OTOMATİK GÜNCEKLEME ####################

readme=$(sed -n 3p README.md |tr -d "Güncelleme ")
guncelleme=$(curl -s "https://github.com/termux-egitim/$buyukad" |grep -o $readme)
if [ "$guncelleme" = "$readme" ];then
	echo
else
	kontrol=$(curl -s https://github.com/termux-egitim/$kucukad |grep -o not-found |wc -w)
	if [[ $kontrol == 0 ]];then
		echo
	else
		echo
		echo
		echo
		printf "\e[31m[!]\e[0m$buyukad GÜNCELLEME YAPILAMIYOR \e[31m!!!\e[0m"
		echo
		echo
		echo
		echo
		sleep 2
		printf "\e[31m[!]\e[0m $buyukad DEPOSU BULUNAMADI \e[31m!!!\e[0m"
		echo
		echo
		exit
	fi

	echo
	echo
	echo
	printf "\e[32m[*]\e[0m $buyukad GÜNCELLENİYOR "
	echo
	echo
	echo
	sleep 2
	rm -rf *
	rm -rf .git
	git clone https://github.com/termux-egitim/$kucukad
	cd $kucukad
	mv * ../
	mv .git ../
	cd ..
	rm -rf $kucukad
	bash .pidkapat.sh
	clear
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m $buyukad GÜNCELLENDİ "
	echo
	echo
	echo
	printf "
	\e[33m
	$(pwd)
	\e[0m"
	echo
	echo
	echo
	ls
	echo
	echo
	echo
	exit
fi

