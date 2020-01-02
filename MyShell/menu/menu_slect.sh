#!/bin/bash
#simple script menu

function diskspace {
    clear
    df -k
}

function whoseon {
    clear
    who
}

function memusage {
    clear
    free -m
}

PS3="Enter your OPtion:"
select option in "disk" "who" "memory" "exit"
do
    case $option in
        "disk")
        diskspace ;;
        "who")
        whoseon ;;
        "memory")
        memusage ;;
        "exit")
        break ;;
        *)
            clear
        echo "Sorry wrong selection" ;;
    esac
done
clear