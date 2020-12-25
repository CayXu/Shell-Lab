#!/bin/bash
touch test12.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl

make test12 >test12.txt

verify1=`sed -n '8p' test12.txt`

verify2=`sed -n '6p' test12.txt`

if [[ ${verify1} =~ 'Stopped ./mysplit 4 ' ]];
then 
	if [[ ${verify2} =~ 'stopped by signal 20' ]];
	then 
		sed -i '6c Job [1] (pid) stopped by signal 20' test12.txt
		sed -i '8c [1] (pid) Stopped ./mysplit 4' test12.txt
		sed -i "/pts/d" test11.txt
		sed  "1d" test12.txt;

	else 
		cat test12.txt;
	fi;
else 
	cat test12.txt;
fi


make clean >/dev/null 2>&1        #make clean（不影响下一次评测）