#!/bin/bash

if [[ "$(ps -A | grep "wlogout" | wc -l)" -le 0 ]];then
    wlogout -sb 2
else
    pkill -USR1 wlogout
fi
