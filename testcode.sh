#nhap cac bien
echo -n "frequency check"
read frequency_check
if [[ ! "$frequency_check" =~ ^[0-9]+$ ]] || [[ $frequency_check =~ ^0+$ ]] || [ -z $frequency_check ]
then
	echo "frequency check: syntax error"
	exit 1
fi



















#check frequency report
#if [ ${#fr_rp[@]} -ne 5 ]
#then
#	echo "fr_rp sai"
#	exit 1
#else
#	IFS="," read -r -a min <<< ${fr_rp[@]}
#fi
