#!/bin/bash
touch test16.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl

make test16 >test16.txt

verify1=`sed -n '7p' test16.txt`

verify2=`sed -n '$p' test16.txt`

if [[ ${verify1} =~ 'stopped by signal 20' ]];
then 
	if [[ ${verify2} =~ 'terminated by signal 2' ]];
	then 
		sed -i '7c Job [1] (pid) stopped by signal 20' test16.txt
		sed -i '9c [1] (pid) Stopped ./mystop 2' test16.txt
		sed -i '$c Job [2] (pid) terminated by signal 2' test16.txt

		sed   "1d" test16.txt;
		
	else 
		cat test16.txt;
	fi;
else 
	cat test16.txt;
fi

make clean >/dev/null 2>&1        #make clean（不影响下一次评测）