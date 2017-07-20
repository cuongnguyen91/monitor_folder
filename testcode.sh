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
			echo "so thang: neu dung dau * thi chi duoc dat 1 dau *"
			exit 1
		else
			IFS="," read -r -a domrp <<< "${fr_rp[2]}"
			if [ "${domrp[0]}" != \* ]
			then
				for y in `eval echo {0..$((${#domrp[@]}-1))}`
				do
					unset subdomrp
					IFS="-" read -r -a subdomrp <<< "${domrp[y]}"
					if [[ ${#subdomrp[@]} -gt 2 || ${subdomrp[0]} -gt 23 || ${subhourrp[1]} -gt 23 || -z "${subhourrp[0]}" || ( ${#subhourrp[@]} -eq 2 && -z "${subhourrp[1]}" ) ]]
					then
					fi
				done
			fi
		fi
	fi
fi
