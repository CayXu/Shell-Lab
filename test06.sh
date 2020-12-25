#!/bin/bash
touch test06.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl

make test06 >test06.txt

verify1=`sed -n '$p' test06.txt`

if [[ ${verify1} =~ 'terminated by signal 2' ]];

then 
	sed -i '6c Job [1] (pid) terminated by signal 2' test06.txt
	sed   "1d" test06.txt;
	
else 
	cat test06.txt;
fi

make clean >/dev/null 2>&1        #make clean（不影响下一次评测）