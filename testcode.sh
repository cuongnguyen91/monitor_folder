
#----
if [ ${#fr_bu[@]} -ne 5 -a ${#fr_bu[@]} -ne 0 ]
then
        echo "config frequency report sai"
        exit 1
else
#kiem tra phut
        if [[ "${fr_bu[0]}" =~ ^[0-9,]{1,14}$ ]]
        then
                IFS="," read -r -a minbu <<< "${fr_bu[0]}"
                for r in `eval echo {0..$((${#minbu[@]}-1))}`
                do
                        if [[ ${minbu[r]} -gt 59 || -z ${minbu[r]} ]]
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
        if [[ "${fr_bu[1]}" =~ ^[0-9*,-]{1,58}$ ]]
        then
                if [[ "${fr_bu[1]}" == *\** ]] && [[ "${#fr_bu[1]}" -ne 1 ]]
                then
                        echo "so gio: neu dung dau * thi chi duoc dat 1 dau *"
                        exit 1
                else
                        IFS="," read -r -a hourrp <<< "${fr_bu[1]}"
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
        if [[ "${fr_bu[2]}" =~ ^[0-9*,-]{1,79}$ ]]
        then
                if [[ "${fr_bu[2]}" == *\** ]] && [[ "${#fr_bu[2]}" -ne 1 ]]
                then
                        echo "so ngay: neu dung dau * thi chi duoc dat 1 dau *"
                        exit 1
                else
                        IFS="," read -r -a domrp <<< "${fr_bu[2]}"
                        if [ "${domrp[0]}" != \* ]
                        then
                                for y in `eval echo {0..$((${#domrp[@]}-1))}`
                                do
                                        unset subdomrp
                                        IFS="-" read -r -a subdomrp <<< "${domrp[y]}"
                                        if [[ ${#subdomrp[@]} -gt 2 || ${subdomrp[0]} -lt 1 || ${subdomrp[0]} -gt 31 || ( ! -z ${subdomrp[1]} && (${subdomrp[1]} -lt 1 || ${subdomrp[1]} -gt 31)) || -z "${subdomrp[0]}" || ( ${#subdomrp[@]} -eq 2 && -z "${subdomrp[1]}" ) ]]
                                        then
                                                echo "so ngay: chi duoc dang x,y hoac x-y, chi tu 1-31"
                                                exit 1
                                        fi 2>/dev/null
                                done
                        fi
                fi
        else
                echo "so ngay: sai cu phap"
                exit 1
        fi
#kiem tra thang
        if [[ "${fr_bu[3]}" =~ ^[0-9a-z*,-]{1,50}$ ]
        then
                if [[ "${fr_bu[3]}" == *\** ]] && [[ "${#fr_bu[3]}" -ne 1 ]]
                then
                        echo "so thang: neu dung dau * thi chi duoc dat 1 dau *"
                        exit 1
                else
                        IFS="," read -r -a monthrp <<< "${fr_bu[3]}"
                        if [ "${monthrp[0]}" != \* ]
                        then
                                for w in `eval echo {0..$((${#monthrp[@]}-1))}`
                                do
                                        unset submonthrp
                                        IFS="-" read -r -a submonthrp <<< "${monthrp[w]}"
                                        if [ ${#submonthrp[@]} -eq 1 ]
                                        then
                                                if [[ ! "${submonthrp[0]}" =~ jan|feb|mar|apr|may|june|july|aug|sept|oct|nov|dec|^1$|^2$|^3$|^4$|^5$|^6$|^7$|^7$|^9$|10|11|12 ]]
                                                then
                                                        echo "so thang sai 1"
                                                        exit 1
                                                fi
                                        elif [ ${#submonthrp[@]} -eq 2 ]
                                        then
                                                case "${submonthrp[0]}" in
                                                jan|feb|mar|apr|may|june|july|aug|sept|oct|nov|dec)
                                                        if [[ ! "${submonthrp[1]}" =~ jan|feb|mar|apr|may|june|july|aug|sept|oct|nov|dec ]]
                                                        then
                                                                echo "so thang sai 2 chu"
                                                                exit 1
                                                        fi
                                                ;;
                                                1|2|3|4|5|6|7|8|9|10|11|12)
                                                        if [[ ! "${submonthrp[1]}" =~ ^1$|^2$|^3$|^4$|^5$|^6$|^7$|^8$|^9$|^10$|^11$|^12$ ]]
                                                        then
                                                                echo "so thang sai 2 so"
                                                                exit 1
                                                        fi
                                                ;;
                                                *)
                                                        echo "so thang sai"
                                                        exit 1
                                                ;;
                                                esac
                                        else
                                                echo "so thang sai 2"
                                                exit 1
                                        fi
                                done
                        fi
                fi
        else
                echo "so thang: sai cu phap"
                exit 1
        fi
#kiem tra ngay trong tuan (0-6)(sunday = 0)
        if [[ "${fr_bu[4]}" =~ ^[0-6a-z,*-]+$ ]]
        then
                if [[ "${fr_bu[4]}" == *\** ]] && [[ "${#fr_bu[4]}" -ne 1 ]]
                then
                        echo "so dow: neu dung dau * thi chi duoc dat 1 dau *"
                        exit 1
                else
                        IFS="," read -r -a dowrp <<< "${fr_bu[4]}"
                        if [ "${dowrp[0]}" != \* ]
                        then
                                for e in `eval echo {0..$((${#dowrp[@]}-1))}`
                                do
                                        unset subdowrp
                                        IFS="-" read -r -a subdowrp <<< "${dowrp[e]}"
                                        if [ ${#subdowrp[@]} -eq 1 ]
                                        then
                                                if [[ ! "${subdowrp[0]}" =~ mon|tue|wed|thu|fri|sat|sun|[0-6] ]]
                                                then
                                                        echo "so ngay trong tuan sai 1"
                                                        exit 1
                                                fi
                                        elif [ ${#subdowrp[@]} -eq 2 ]
                                        then
                                                case "${subdowrp[0]}" in
                                                1|2|3|4|5|6|0)
                                                        if [[ ! "${subdowrp[1]}" =~ ^[0-6]$ ]]
                                                        then
                                                                echo "so ngay trong tuan sai 2"
                                                                exit 1
                                                        fi
                                                ;;
                                                mon|tue|wed|thu|fri|sat|sun)
                                                       if [[ ! "${subdowrp[1]}" =~ mon|tue|wed|thu|fri|sat|sun ]]
                                                        then
                                                                echo "so ngay trong tuan sai 3"
                                                                exit 1
                                                        fi
                                                ;;
                                                *)
                                                        echo "so ngay trong tuan sai 4"
                                                        exit 1
                                                ;;
                                                esac
                                        else
                                                        echo "so ngay trong tuan sai 5"
                                                        exit 1

                                        fi
                                done
                        fi
                fi
        else
                echo "so ngay trong tuan sai 6"
                exit 1
        fi
fi

