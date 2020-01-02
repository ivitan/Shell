#! /bin/bash
#simple script menu

function diskspace {
    clear
    df -h
}

function whoseon {
    clear
    who
}

function memusage {
    clear
    free -m
}

function menu {
    clear
    echo
    echo " SysAdmin Menu"
    echo "1.Dispaly Disk usage"
    echo "2.Dispaly who are on"
    echo "3.Display memuage "
    echo "Enter your choice:"
    read -n 1 option
}

while [ 1 ]
do
    menu
    case $option in
        0)
        break ;;
        1)
        diskspace ;;
        2)
        whoseon ;;
        *)
            clear
        echo "sorry wrong selection" ;;
    esac
    echo "Hit any key to continue"
    read -n 1 option
done
clear

