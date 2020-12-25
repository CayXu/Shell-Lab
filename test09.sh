#!/bin/bash
touch test09.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl

make test09 >test09.txt

verify1=`sed -n '12p' test09.txt`

verify2=`sed -n '$p' test09.txt`

if [[ ${verify1} =~ 'tsh> bg %2' ]];
then 
	if [[ ${verify2} =~ 'Running ./myspin 5' ]];
	then 
		sed -i '6c [1] (pid) ./myspin 4 &' test09.txt
		sed -i '8c Job [2] (pid) stopped by signal 20' test09.txt
		sed -i '10c [1] (pid) Running ./myspin 4 &' test09.txt
		sed -i '11c [2] (pid) Stopped ./myspin 5 ' test09.txt
		sed -i '13c [2] (pid) ./myspin 5 ' test09.txt
		sed -i '15c [1] (pid) Running ./myspin 4 &' test09.txt
		sed -i '16c [2] (pid) Running ./myspin 5 ' test09.txt
		sed   "1d" test09.txt;
		
	else 
		cat test09.txt;
	fi;
else 
	cat test09.txt;
fi

make clean >/dev/null 2>&1        #make clean（不影响下一次评测）