#!/bin/bash

# gets dimensions of monitor the active window is on
screen=($(screenheighttaskbar2.sh))
#screen=($(currentscreenall.sh window | awk 'BEGIN {FS="x"} {print $1, $2}'))

screen_width=${screen[0]}
screen_height=${screen[1]}

# gets info related to active window
info=($(xwininfo -id $(xdotool getactivewindow) | awk 'BEGIN {FS=":"} {print $2}'))

xpos=${info[2]}
ypos=${info[3]}
width=${info[6]}
height=${info[7]}

# window sizing
if      [ $height -gt $(($screen_height / 2)) ] && [ $width -gt $(($screen_width / 2)) ]; then
    size="full_width_full_height"
elif    [ $height -gt $(($screen_height / 2)) ] && [ $width -lt $(($screen_width / 2)) ]; then
    size="half_width_full_height"
else
    size="half_height"
fi

case $1 in
    "up")
        if      [ "$size" == "half_width_full_height" ]; then
            echo "Resize frame keep $(($screen_height / 2))p"
        else
            echo "LeeMaximize"
        fi
        ;;
    "down")
        if      [ "$ypos" -lt 30 ] && [ "$size" == "half_height" ]; then
            echo "Move keep $(($screen_height / 2))p"
        elif    [ "$size" == "half_width_full_height" ]; then
            echo "ResizeMove frame keep $(($screen_height / 2))p keep $(($screen_height / 2))p"
        else
            echo "LeeIconify"
        fi
esac

# side may be irrelevant
# if      ((xpos >= 1920 && xpos <= 1930)) || ((xpos >= 0 && xpos <= 10)); then
#     side="left"
# else
#     side="right"
# fi
