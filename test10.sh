#!/bin/bash
touch test10.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl

make test10 >test10.txt

verify1=`sed -n '7p' test10.txt`

verify2=`sed -n '$p' test10.txt`

if [[ ${verify1} =~ 'tsh> fg %1' ]];
then 
	if [[ ${verify2} =~ 'tsh> jobs' ]];
	then 
		sed -i '6c [1] (pid) ./myspin 4 &' test10.txt
		sed -i '8c Job [1] (pid) stopped by signal 20' test10.txt
		sed -i '10c [1] (pid) Stopped ./myspin 4 &' test10.txt
		sed   "1d" test10.txt;
		
	else 
		cat test10.txt;
	fi;
else 
	cat test10.txt;
fi


make clean >/dev/null 2>&1        #make clean（不影响下一次评测）