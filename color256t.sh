#/bin/bash
## This is a 256-colors test script,
## Writen by callcz 20220730.
#  Options :
#    --code,-c	Print code.
#    --fg,-f	Font color.
#    --bg,-b	Backgrond color.
#    --help,-h	List this help.
#    --word,-w	Print word

space=' '
space2=$space
for cmd in $@
do
	if [[ $code -eq 2 ]]
	then
		w=$cmd
	fi
	case $cmd in
		--code)
			code=1
			;;
		-c)
			code=1
			;;
		--help)
			head -n9 $0
			exit
			;;
		-h)
			head -n9 $0
			echo '  'Note: Use \" \$echo \'\\E[0m\' \" for cancel color style .
			echo #new line
			exit
			;;
		--fg)
			cfg=1
			;;
		-f)
			cfg=1
			;;
		--bg)
			cbg=1
			;;
		-b)
			cbg=1
			;;
		--word)
			code=2
			;;
		-w)
			code=2
			;;
	esac
done

for fgbg in 38 48
do
	for color in {0..255}
	do
		if [[ $cfg -eq 1 && $fgbg -eq 48 ]]
		then
			break
		fi
		if [[ $cbg -eq 1 && $fgbg -eq 38 ]]
		then
			break
		fi
		if [[ $code -eq 1 ]]
		then
			#unset space
			color_code="\E[${fgbg};5;${color}m"
			width=-12
		elif [[ $code -eq 2 ]]
		then
			#unset space
			#unset space2
			color_code=$w
			width=${#w}
		else
			#unset space2
			color_code=${color}
			width=3
		fi
		printf "\033[${fgbg};5;%sm${space2}%${width}s${space}\033[0m" $color $color_code
		if [[ $(($((color+1))%4)) -eq 0 ]]
		then
			echo #newline
		fi
	done
done
exit

