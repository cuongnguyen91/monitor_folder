#========================================================================
#bat dau vao chuong trinh
#tao file so sanh dau tien
touch "$dir_report/rpfile0"
ls -la ${dir_monitor[@]}  >> "$dir_report/rpfile1"

#| grep -v ^total | grep -v "\ \.$" | grep -v "\ \.\."
