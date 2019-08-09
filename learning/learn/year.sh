#! /bin/bash
# 根据系统时间计算今年或明年
echo "This is $(date +%Y) year"

echo "Next year is $(($(date +%Y) + 1))"

echo "今天是今年的第 $(date +%j) 天"

echo "今年已过了 $(($(date +%j)/7)) 星期"

echo "今年还剩 $((365 - $(date +%j))) 天"

echo "今年还剩 $(((365 - $(date +%j))/7)) 星期"