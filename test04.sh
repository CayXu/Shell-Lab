#!/bin/bash
touch test04.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl

make test04 >test04.txt

verify1=`sed -n '$p' test04.txt`

if [[ ${verify1} =~ './myspin 1 &' ]];

then 
	sed -i '6c [1] (pid) ./myspin 1 &' test04.txt
	sed   "1d" test04.txt;
	
else 
	cat test04.txt;
fi


make clean >/dev/null 2>&1        #make clean（不影响下一次评测）