#!/bin/bash
touch test07.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl

make test07 >test07.txt


verify1=`sed -n '8p' test07.txt`

verify2=`sed -n '$p' test07.txt`

if [[ ${verify1} =~ 'terminated by signal 2' ]];
then 
	if [[ ${verify2} =~ 'Running ./myspin 4 &' ]];
	then 
		sed -i '6c [1] (pid) ./myspin 4 &' test07.txt
		sed -i '8c Job [2] (pid) terminated by signal 2' test07.txt
		sed -i '10c [1] (pid) Running ./myspin 4 &' test07.txt
		sed   "1d" test07.txt;
		
	else 
		cat test07.txt;
	fi;
else 
	cat test07.txt;
fi

make clean >/dev/null 2>&1        #make clean（不影响下一次评测）