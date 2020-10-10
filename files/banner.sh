#!/bin/bash

#################### GÜNLER ####################

pazartesi=$(date |grep -o Mon)
sali=$(date |grep -o Tue)
carsamba=$(date |grep -o Wed)
persembe=$(date |grep -o Thu)
cuma=$(date |grep -o Fri)
cumartesi=$(date |grep -o Sat)
pazar=$(date |grep -o Sun)

#################### GÜNLERE GÖRE RENKLER ####################

if [[ $pazartesi == Mon ]];then
	renk1='\e[0m'
	renk2='\e[32m'
elif [[ $sali == Tue ]];then
	renk1='\e[0m'
	renk2='\e[31m'
elif [[ $carsamba == Wed ]];then
	renk1='\e[0m'
	renk2='\e[33m'
elif [[ $persembe == Thu ]];then
	renk1='\e[0m'
	renk2='\e[34m'
elif [[ $cuma == Fri ]];then
	renk1='\e[0m'
	renk2='\e[36m'
elif [[ $cumartesi == Sat ]];then
	renk1='\e[31m'
	renk2='\e[34m'
elif [[ $pazar == Sun ]];then
	renk1='\e[33m'
	renk2='\e[34m'
fi

#################### BANNER ####################

printf "
$renk1

      _     _  _____  __   _ _     _ _______
      |____/  |     | | \  | |     | |  |  |
      |    \_ |_____| |  \_| |_____| |  |  |
$renk2
                     ______  _     _        _______ _______
                     |_____] |     | |      |  |  | |_____|
                     |_____] |_____| |_____ |  |  | |     |

                                    \e[33mSON GÜNCELLEME :\e[0m $(cd .. && sed -n 3p README.md |tr -d "Güncelleme ")
           \e[31m////////// \e[32mTERMUX EĞİTİM \e[31m//////////\e[32m
   
           Coded By  \e[31m>\e[0m UmuT KaRa\e[32m
	   TELEGRAM  \e[31m>\e[0m @termuxegitimm\e[32m
           İNSTAGRAM \e[31m>\e[0m @termuxegitim\e[32m
           GİTHUB    \e[31m>\e[0m termux-egitim

\e[0m
"
