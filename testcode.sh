#nhap cac bien
echo -n "fr_rp"
read -a fr_rp


#check frequency report
if [ ${#fr_rp[@]} -ne 5 ]
then
	echo "file config sai"
	exit 1
else
#kiem tra phut 
	if [[ "${fr_rp[0]}" =~ ^[0-9,]{1,14}$ ]]
	then
		IFS="," read -r -a minrp <<< "${fr_rp[0]}"
		for r in `eval echo {0..$((${#minrp[@]}-1))}`
		do
			if [ ${minrp[r]} -gt 59 ]
			then
				echo "so phut chi trong khoang 0-59"
				exit 1
			fi
		done
	else
		echo "so phut sai syntax"
		exit 1
	fi
#kiem tra gio
	if [[ "${fr_rp[1]}" =~ ^[0-9*,-]{1,58}$ ]]
	then
		if [[ "${fr_rp[1]}" == *\** ]] && [[ "${#fr_rp[1]}" -ne 1 ]]
		then
			echo "neu dung dau * thi chi duoc dat 1 dau *"
			exit 1
		else
			IFS="," read -r -a hourrp <<< "${fr_rp[1]}"
			if [ "${hourrp[0]}" != \* ]
			then
				for t in `eval echo {0..$((${#hourrp[@]}-1))}`
				do
				done
			fi
		fi
	else
		echo "so gio sai cu phap"
		exit 1
	fi
fi

