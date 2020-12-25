#!/bin/bash
touch test05.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl

make test05 >test05.txt

verify1=`sed -n '9p' test05.txt`

verify2=`sed -n '$p' test05.txt`

if [[ ${verify1} == 'tsh> jobs' ]];
then 
	if [[ ${verify2} =~ 'Running ./myspin 3 &' ]];
	then 
		sed -i '6c [1] (pid) ./myspin 2 &' test05.txt
		sed -i '8c [2] (pid) ./myspin 3 &' test05.txt
		sed -i '10c [1] (pid) Running ./myspin 2 &' test05.txt
		sed -i '11c [2] (pid) Running ./myspin 3 &' test05.txt
		sed   "1d" test05.txt;
		
	else 
		cat test05.txt;
	fi;
else 
	cat test05.txt;
fi

make clean >/dev/null 2>&1        #make clean（不影响下一次评测）