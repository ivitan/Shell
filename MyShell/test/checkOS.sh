#!/bin/sh
SYSTEM=`rpm -q centos-release|cut -d- -f3`
if
[ $SYSTEM = "6" ];then
echo "CentOs 6"
elif [ $SYSTEM = "7" ];then
echo "CentOS 7"
elif [ $SYSTEM = "5" ];then
echo "CentOS 5"
else
echo "What?"
fi
