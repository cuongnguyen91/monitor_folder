#nhap cac bien
echo -n "mail_rp="
read -a mail_rp

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

