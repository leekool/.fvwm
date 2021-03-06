#!/bin/sh

screen1=($(xrandr | grep -w connected  | sed 's/primary //' | awk -F'[ +]' '{print $1,$3,$4}' |
    head -n 1))
screen2=($(xrandr | grep -w connected  | sed 's/primary //' | awk -F'[ +]' '{print $1,$3,$4}' |
    tail -n 1))

# figure out which screen is to the right of which
if [ ${screen1[2]} -eq 0  ]; then
    right=(${screen2[@]});
    left=(${screen1[@]});
else
    right=(${screen1[@]});
    left=(${screen2[@]});
fi

# "window" gets the screen the focused window is on
# "mouse" gets the screen the cursor is on
# "taskbar" gets the screen the taskbar is on
case $1 in
    "window")
        pos=$(xwininfo -id $(xdotool getactivewindow) | awk 'NR==4{print $NF}');
        ;;
    "mouse")
        pos=$(xdotool getmouselocation --shell | awk 'NR==1{print substr ($1, 3)}')
        ;;
    "taskbar")
        pos=$(xwininfo -name FvwmButtons | awk 'NR==4{print $NF}')
        ;;
esac

# which screen is this window displayed in? if $pos
# is greater than the offset of the rightmost screen,
# then the window is on the right hand one
if [ "$pos" -gt "${right[2]}" ]; then
    echo "${right[1]}"
else
    echo "${left[1]}"
fi
