#!/bin/bash
touch test03.txt
make >/dev/null 2>&1     #make编译（并将多余的输出信息”丢掉“）

chmod +x tsh.c
chmod +x sdriver.pl

make test03 >test03.txt

sed "1d" test03.txt

make clean >/dev/null 2>&1        #make clean（不影响下一次评测）