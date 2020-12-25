#!/bin/bash
touch test08.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl

make test08 >test08.txt
verify1=`sed -n '8p' test08.txt`

verify2=`sed -n '$p' test08.txt`

if [[ ${verify1} =~ 'stopped by signal 20' ]];
then
	if [[ ${verify2} =~ 'Stopped ./myspin 5' ]];
	then 
		sed -i '6c [1] (pid) ./myspin 4 &' test08.txt
		sed -i '8c Job [2] (pid) stopped by signal 20' test08.txt
		sed -i '10c [1] (pid) Running ./myspin 4 &' test08.txt
		sed -i '11c [2] (pid) Stopped ./myspin 5 ' test08.txt
		sed   "1d" test08.txt;
		
	else 
		cat test08.txt;
	fi;
else 
	cat test08.txt;
fi

make clean >/dev/null 2>&1        #make clean（不影响下一次评测）