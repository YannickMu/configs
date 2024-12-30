#!/bin/bash

hyprctl activewindow | sed -n -E 's/\tinitialTitle: (.*)/\1/p'
