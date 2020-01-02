#!/bin/bash
#using dialog to create menu

temp=`mktemp -t test.XXXXXX`
temp2=`mktemp -t test.XXXXXX`

function diskspace {
    df -k > $temp
    dialog --textbox $temp 20 50
}

function whoseon {
    who > $temp
    dialog --textbox $temp 20 50
}


function memusage {
    free -m > $temp
    dialog --textbox $temp 20 50
}

while [ 1 ]
do
    dialog --menu "Sys Menu" 20 30 10 1 "disk" 2 "users" 3 "memory" 0 "exit" 2> $temp2
    if [ $? -eq 1 ]
    then
        break
    fi
    
    selection=`cat $temp2`
    case $selection in
        1)
        diskspace ;;
        2)
        whoseon ;;
        3)
        memusage ;;
        0)
        break ;;
        *)
            dialog --msgbox "Sorry invalid selection" 10 30
    esac
done
rm -f $temp 2> /dev/null
rm -r $temp2 2> /dev/null