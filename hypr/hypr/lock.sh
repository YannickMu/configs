#!/bin/bash

ln -f ~/wallpaper/lock/"$(ls ~/wallpaper/ -Ap | grep -v / | shuf -n 1)" ~/wallpaper/lock/lock-screen && hyprlock
