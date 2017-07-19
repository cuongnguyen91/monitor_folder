#!/bin/bash
. /monitor.config
#get array from value of variable
IFS="," read -r -a dir_mon <<< "$dir_monitor"
IFS="," read -r -a mail_rp <<< "$mail"
read -r -a fr_rp <<< "$frequency_report"
IFS="," read -r -a fr_bu <<< "$frequency_backup_rp"
#check value
#directory monitor
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
#mail
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
#frequency check
if [[ ! "$frequency_check" =~ ^[0-9]+$ ]] || [[ $frequency_check =~ ^0+$ ]] || [ -z $frequency_check ]
then
        echo "frequency check: syntax error"
        exit 1
fi
#kiem tra thu muc chua file report
if [ -z $dir_report ] || [ ! -d "$dir_report" ]
then
        echo "file config sai"
        exit 1
fi







tbegin=$(date +%s)

