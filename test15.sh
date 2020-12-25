#!/bin/bash
touch test15.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl

make test15 >test15.txt

verify1=`sed -n '6p' test15.txt`

verify2=`sed -n '24p' test15.txt`

if [[ ${verify1} =~ './bogus:Command not found.' ]];
then 
	if [[ ${verify2} =~ './myspin 3 &' ]];
	then 
		sed -i '8c Job [1] (pid) terminated by signal 2' test15.txt
		sed -i '10c [1](pid)./myspin 3 &' test15.txt
		sed -i '12c [2](pid)./myspin 4 &' test15.txt
		sed -i '14c [1] (pid) Running ./myspin 3 &' test15.txt
		sed -i '15c [2] (pid) Running ./myspin 4 &' test15.txt
		sed -i '17c Job [1] (pid) stopped by signal 20' test15.txt
		sed -i '19c [1] (pid) Stopped ./myspin 3 &' test15.txt
		sed -i '20c [2] (pid) Running ./myspin 4 &' test15.txt
		sed -i '24c [1] (pid) ./myspin 3 &' test15.txt
		sed -i '26c [1] (pid) Running ./myspin 3 &' test15.txt
		sed -i '27c [2] (pid) Running ./myspin 4 &' test15.txt
		sed   "1d" test15.txt;
		
	else 
		cat test15.txt;
	fi;
else 
	cat test15.txt;
fi

make clean >/dev/null 2>&1        #make clean（不影响下一次评测）