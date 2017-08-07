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
