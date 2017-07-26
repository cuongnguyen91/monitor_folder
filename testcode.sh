#nhap cac bien
echo -n "fr_rp"
read -a fr_rp


#check frequency report
if [ ${#fr_rp[@]} -ne 5 ]
then
	echo "config khong giong voi crontab (#5 doi so)"
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
					if [ ${submonthrp[0]} -lt 1 -o ${submonthrp[0]} -gt 12 ]
					then
						echo "so thang: chi tu 1-12 hoac dang viet tat cua Tieng Anh"
						exit 1
					fi 2>/dev/null
				done 
			fi
		fi
	else
		echo "so thang: sai cu phap"
                exit 1
	fi
fi


# "${submonthrp[1]}" =~ jan|feb|mar|apr|may|june|july|aug|sept|oct|nov|dec|[0-9]+ 
