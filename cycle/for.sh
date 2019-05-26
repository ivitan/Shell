#!/bin/bash  
  
for i in $(seq 1 11)  
do   
echo $(expr PRO$i);  
done

echo "-----------------------"
for i in {1..10}
do
	echo $i
done