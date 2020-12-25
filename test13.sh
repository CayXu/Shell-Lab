#!/bin/bash
touch test13.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl

make test13 >test13.txt

verify1=`sed -n '12p' test13.txt`

verify2=`sed -n '11p' test13.txt`

if [[ ${verify1} =~ 'tsh> /bin/ps a' ]];
then 
	if [[ ${verify2} =~ 'tsh> fg %1' ]];
	then 
		sed -i '6c Job [1] (pid) stopped by signal 20' test13.txt
		sed -i '8c [1] (pid) Stopped ./mysplit 4 ' test13.txt
		sed   "1d" test13.txt;
		
	else 
		cat test13.txt;
	fi;
else 
	cat test13.txt;
fi

make clean >/dev/null 2>&1        #make clean（不影响下一次评测）