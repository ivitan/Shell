#!/bin/sh
SYSTEM=`rpm -q centos-release|cut -d- -f3`
if
[ $SYSTEM = "6" ] ; then
echo "6"
elif [ $SYSTEM = "7" ] ; then
echo "7"
elif [ $SYSTEM = "5" ] ; then
echo "5"
else
echo "What?"
fi
