#!/bin/bash
touch test11.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl
chmod +x tshref
chmod +x mysplit
chmod +x myint
chmod +x myspin
chmod +x mystop

make test11 >test11.txt

verify1=`sed -n '6p' test11.txt`

verify2=`sed -n '8p' test11.txt`

if [[ ${verify1} =~ 'terminated by signal 2' ]];
then 
	if [[ ${verify2} =~ ' PID TTY      STAT   TIME COMMAND' ]];
	then 
		sed -i '6c Job [1] (pid) terminated by signal 2' test11.txt
		sed -i "/pts/d" test11.txt
		sed  "1d" test11.txt;
		
	else 
		cat test11.txt;
	fi;
else 
	cat test11.txt;
fi


make clean >/dev/null 2>&1        #make clean（不影响下一次评测）