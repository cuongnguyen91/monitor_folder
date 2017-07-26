# monitor_folder
monitor folder in linux by bash shell
mail from command line
install mailx & sendmail
https://www.systutorials.com/1411/sending-email-from-mailx-command-in-linux-using-gmails-smtp/

theo doi bang lenh `ls -l`

Note
*thu muc duoc theo doi
-ho tro nhieu thu muc.
-thu muc phai ton tai va co the truy cap duoc.
-de duong dan trong dau "", giua cac duong dan phan cach bang dau ",".
*mail nhan bao cao:
-ho tro nhieu mail
-de mail trong dau "" va phan cach bang dau ","
-mail co cu phap dang XXXX@YYY.ZZZ, phai co du cac thanh phan
 + XXXX:ky tu hoa, thuong, so va ._%+-
 + YYY: ky tu hoa, thuong,so va .-
 + ZZZ: ky tu hoa, thuong va chi gioi han trong 2-4 ky tu
*thu muc chua file report:
-chi 1 thu muc
-thu muc co ton tai, co quyen truy cap.
*tan so check:
-chi tinh theo phut.
*tan so report:
-Cu phap tuong tu nhu crontab.
-phai du 5 doi so.
	+phut chi duoc dung so.
	+gio duoc dung so va dau *.
-phut:
	+khong co dau *
	+khong chap nhan dau -
	+duoc dung dau , => co nhieu doi so, lon nhat 5 doi so.
	+chi gioi han 0-23
-gio:
	+neu dung dau * thi chi 1 dau *
	+doi so chi tu 0-23
	+ngan cach boi dau ,
	+co the chon 1 dai gio VD: 3-7
	+cao nhat 22 doi tuong.
-day of mounth:
	+chi duoc dung so.
	+co the dung x-y,c-d hoac x,y,z
	+doi so chi duoc tu 1-31
https://www.ibm.com/developerworks/library/l-bash-test/index.html
