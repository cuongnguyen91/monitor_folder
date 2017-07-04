#!/bin/bash
. /monitor.config
IFS="," read -r -a dir_mon <<< "$dir_monitor"
IFS="," read -r -a mail_rp <<< "$mail"
IFS="," read -r -a fr_rp <<< "$frequency_report"
IFS="," read -r -a fr_bu <<< "$frequency_backup_rp"
tbegin=$(date +%s)

