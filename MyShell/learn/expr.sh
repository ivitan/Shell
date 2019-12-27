#! /bin/bash
# 输入一个正整数num，后计算1+2+3+...+num，必须对nun是否是正整数做判断，不符合应当允许再次输入
# expr 只能进行整数运算

while true
do
    read -p "pls input a postive number:" num

    expr $num + 1 &> /dev/null #判断是否为整数

    if [ $? -eq 0 ];then
        if [ `expr $num \> 0` -eq 1 ];then
            for((i=1;i<=$num;i++))
            do
                sum=`expr $sum + $i`
            done
            echo "1+2+3+...+$num = $sum"
            exit
        fi
    fi
    echo "erroe,input enlegal"
    continue
done