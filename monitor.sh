#!/bin/bash
. ./monitor.config
#get array from value of variable
IFS="," read -r -a dir_mon <<< "$dir_monitor"
IFS="," read -r -a mail_rp <<< "$mail"
read -r -a fr_rp <<< "$frequency_report"
IFS="," read -r -a fr_bu <<< "$frequency_backup_rp"
#check value
#-----directory monitor
if [ ${#dir_mon[@]} == 0 ]
then
        echo "file config sai"
        exit 1
else
        for i in `eval echo {0..$((${#dir_mon[@]}-1))}`
        do
                if [ ! -d ${dir_mon[i]} ]
                then
                        echo "diretory not exist"
                        exit 1
                fi
        done
fi
#----mail
if [ ${#mail_rp[@]} == 0 ]
then
        echo "mail adress not found"
        exit 1
else
        for q in `eval echo {0..$((${#mail_rp[@]}-1))}`
        do
                if [[ ! "${mail_rp[q]}" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]
                then
                        echo "mail: syntax error"
                        exit 1
                fi
        done
fi
#------frequency check
if [[ ! "$frequency_check" =~ ^[0-9]+$ ]] || [[ $frequency_check =~ ^0+$ ]] || [ -z $frequency_check ]
then
        echo "frequency check: syntax error"
        exit 1
fi
#------kiem tra thu muc chua file report
if [ -z $dir_report ] || [ ! -d "$dir_report" ]
then
        echo "file config sai"
        exit 1
fi



#----check frequency report
if [ ${#fr_rp[@]} -ne 5 -a ${#fr_rp[@]} -ne 0 ]
then
	echo "config frequency report sai"
	exit 1
else
#kiem tra phut 
	if [[ "${fr_rp[0]}" =~ ^[0-9,]{1,14}$ ]]
	then
		IFS="," read -r -a minrp <<< "${fr_rp[0]}"
		for r in `eval echo {0..$((${#minrp[@]}-1))}`
		do
			if [[ ${minrp[r]} -gt 59 || -z ${minrp[r]} ]]
			then
				echo "so phut: chi trong khoang 0-59, khong duoc de trong"
				exit 1
			fi
		done
	else
		echo "so phut: sai cu phap"
		exit 1
	fi
#kiem tra gio
	if [[ "${fr_rp[1]}" =~ ^[0-9*,-]{1,58}$ ]]
	then
		if [[ "${fr_rp[1]}" == *\** ]] && [[ "${#fr_rp[1]}" -ne 1 ]]
		then
			echo "so gio: neu dung dau * thi chi duoc dat 1 dau *"
			exit 1
		else
			IFS="," read -r -a hourrp <<< "${fr_rp[1]}"
			if [ "${hourrp[0]}" != \* ]
			then
				for t in `eval echo {0..$((${#hourrp[@]}-1))}`
				do
					unset subhourrp
					IFS="-" read -r -a subhourrp <<< "${hourrp[t]}"
					if [[ ${#subhourrp[@]} -gt 2 || ${subhourrp[0]} -gt 23 || ${subhourrp[1]} -gt 23 || -z "${subhourrp[0]}" || ( ${#subhourrp[@]} -eq 2 && -z "${subhourrp[1]}" ) ]]
					then
						echo "so gio: chi trong khoang 0-23, khong duoc rong hoac nhieu dau -"
						exit 1
					fi 2>/dev/null
				done
			fi
		fi
	else
		echo "so gio: sai cu phap"
		exit 1
	fi
#kiem tra ngay (trong thang)
	if [[ "${fr_rp[2]}" =~ ^[0-9*,-]{1,79}$ ]]
	then
		if [[ "${fr_rp[2]}" == *\** ]] && [[ "${#fr_rp[2]}" -ne 1 ]]
		then
			echo "so ngay: neu dung dau * thi chi duoc dat 1 dau *"
			exit 1
		else
			IFS="," read -r -a domrp <<< "${fr_rp[2]}"
			if [ "${domrp[0]}" != \* ]
			then
				for y in `eval echo {0..$((${#domrp[@]}-1))}`
				do
					unset subdomrp
					IFS="-" read -r -a subdomrp <<< "${domrp[y]}"
					if [[ ${#subdomrp[@]} -gt 2 || ${subdomrp[0]} -lt 1 || ${subdomrp[0]} -gt 31 || ( ! -z ${subdomrp[1]} && (${subdomrp[1]} -lt 1 || ${subdomrp[1]} -gt 31)) || -z "${subdomrp[0]}" || ( ${#subdomrp[@]} -eq 2 && -z "${subdomrp[1]}" ) ]]
					then
						echo "so ngay: chi duoc dang x,y hoac x-y, chi tu 1-31"
						exit 1
					fi 2>/dev/null
				done
			fi
		fi
	else
		echo "so ngay: sai cu phap"
		exit 1
	fi
#kiem tra thang
	if [[ "${fr_rp[3]}" =~ ^[0-9a-z*,-]{1,50}$ ]]
	then
		if [[ "${fr_rp[3]}" == *\** ]] && [[ "${#fr_rp[3]}" -ne 1 ]]
		then
                        echo "so thang: neu dung dau * thi chi duoc dat 1 dau *"
                        exit 1
		else
			IFS="," read -r -a monthrp <<< "${fr_rp[3]}"
			if [ "${monthrp[0]}" != \* ]
			then
				for w in `eval echo {0..$((${#monthrp[@]}-1))}`
				do
					unset submonthrp
					IFS="-" read -r -a submonthrp <<< "${monthrp[w]}"
					if [ ${#submonthrp[@]} -eq 1 ]
					then
						if [[ ! "${submonthrp[0]}" =~ jan|feb|mar|apr|may|june|july|aug|sept|oct|nov|dec|^1$|^2$|^3$|^4$|^5$|^6$|^7$|^7$|^9$|10|11|12 ]]
						then
							echo "so thang sai 1"
							exit 1
						fi
					elif [ ${#submonthrp[@]} -eq 2 ]
					then
						case "${submonthrp[0]}" in
						jan|feb|mar|apr|may|june|july|aug|sept|oct|nov|dec)
							if [[ ! "${submonthrp[1]}" =~ jan|feb|mar|apr|may|june|july|aug|sept|oct|nov|dec ]]
							then
								echo "so thang sai 2 chu"
								exit 1
							fi
						;;
						1|2|3|4|5|6|7|8|9|10|11|12)
                                                        if [[ ! "${submonthrp[1]}" =~ ^1$|^2$|^3$|^4$|^5$|^6$|^7$|^8$|^9$|^10$|^11$|^12$ ]]
                                                        then
								echo "so thang sai 2 so"
								exit 1
                                                        fi
						;;
						*)
							echo "so thang sai"
							exit 1
						;;
						esac
					else
						echo "so thang sai 2"
						exit 1
					fi 
				done 
			fi
		fi
	else
		echo "so thang: sai cu phap"
                exit 1
	fi
#kiem tra ngay trong tuan (0-6)(sunday = 0)
	if [[ "${fr_rp[4]}" =~ ^[0-6a-z,*-]+$ ]]
	then
		if [[ "${fr_rp[4]}" == *\** ]] && [[ "${#fr_rp[4]}" -ne 1 ]]
		then
                        echo "so dow: neu dung dau * thi chi duoc dat 1 dau *"
                        exit 1
		else
			IFS="," read -r -a dowrp <<< "${fr_rp[4]}"
			if [ "${dowrp[0]}" != \* ]
			then
				for e in `eval echo {0..$((${#dowrp[@]}-1))}`
				do
					unset subdowrp
					IFS="-" read -r -a subdowrp <<< "${dowrp[e]}"
					if [ ${#subdowrp[@]} -eq 1 ]
					then
						if [[ ! "${subdowrp[0]}" =~ mon|tue|wed|thu|fri|sat|sun|[0-6] ]]
						then
							echo "so ngay trong tuan sai 1" 
							exit 1
						fi
					elif [ ${#subdowrp[@]} -eq 2 ]
					then
						case "${subdowrp[0]}" in
						1|2|3|4|5|6|0)
							if [[ ! "${subdowrp[1]}" =~ ^[0-6]$ ]]
	        	                                then
                                        	                echo "so ngay trong tuan sai 2"
                                	                        exit 1
                        	                        fi
						;;
						mon|tue|wed|thu|fri|sat|sun)
                                                       if [[ ! "${subdowrp[1]}" =~ mon|tue|wed|thu|fri|sat|sun ]]
                                                        then
                                                                echo "so ngay trong tuan sai 3"
                                                                exit 1
                                                        fi
						;;
						*)
	                                                echo "so ngay trong tuan sai 4"
        	                                        exit 1
						;;
						esac
					else
                                                  	echo "so ngay trong tuan sai 5"
                                                        exit 1

					fi
				done
			fi
		fi
	else
		echo "so ngay trong tuan sai 6"
		exit 1
	fi
fi
#check size_backup_rp
if [[ "$size_backup_rp" =~ ^[0-9]+$ ]]
then
	if [ $size_backup_rp -lt 3 ]
	then
		echo "so size rp >= 3"
		exit 1
	fi
else
	if [ ! -z "$size_backup_rp" ]
	then
	        echo "size chi o~ dang so"
	        exit 1
	fi

fi
tbegin=$(date +%s)
