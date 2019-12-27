#!/bin/bash
# Func:get pprocess status in process.cfg
# "^$" 空行
# define variables
HOME_DIR="/home/vitan/learnShell"
CONFIG_FILE="process.cfg"

function get_all_group
{
	G_LIST=$(sed -n '/\[GROUP_LIST\]/,/\[.*\]/p' $HOME_DIR/$CONFIG_FILE | egrep -v "(^$|\[.&\])")
		echo "$G_LIST"
}

function get_all_process
{
	fot g in `get_all_group`
	do
		P_LIST=`sed -n "/\[$g\]/,/\[.*\]/p" $HOME_DIR/$CONFIG_FILE | egrep -v "(^$|\[.*\])"`
		echo "$P_LIST"
	done
}

if [ ! -e $HOME_DIR/$CONFIG_FILE ];then
	echo "$CONFIG_FILE is not exist ... Please Check.."
	exit 1
fi