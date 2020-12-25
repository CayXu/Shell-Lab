#!/bin/bash
touch test02.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl

make test02 >test02.txt

sed "1d" test02.txt

make clean >/dev/null 2>&1        #make clean（不影响下一次评测）