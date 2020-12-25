#!/bin/bash
touch test14.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl

make test14 >test14.txt

verify1=`sed -n '18p' test14.txt`

verify2=`sed -n '26p' test14.txt`

if [[ ${verify1} =~ 'No such process' ]];
then 
	if [[ ${verify2} =~ 'No such job' ]];
	then 
		sed -i '8c [1] (pid) ./myspin 4 &' test14.txt
		sed -i '24c Job [1] (pid) stopped by signal 20' test14.txt
		sed -i '28c [1] (pid) ./myspin 4 &' test14.txt
		sed -i '30c [1] (pid) Running ./myspin 4 &' test14.txt
		sed   "1d" test14.txt;
		
	else 
		cat test14.txt;
	fi;
else 
	cat test14.txt;
fi

make clean >/dev/null 2>&1        #make clean（不影响下一次评测）