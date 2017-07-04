#!/bin/bash
. /monitor.config
#get array from value of variable
IFS="," read -r -a dir_mon <<< "$dir_monitor"
IFS="," read -r -a mail_rp <<< "$mail"
IFS="," read -r -a fr_rp <<< "$frequency_report"
IFS="," read -r -a fr_bu <<< "$frequency_backup_rp"
#check value
if ( ! -d $dir_mon[i] )
then
  echo "diretory not exist"
  exit 1
fi
tbegin=$(date +%s)

