#!/bin/bash

# This pauses dunst on screenlock


pkill -u "$USER" -USR1 dunst
xset dpms force off
i3lock -c 000000 -n
pkill -u "$USER" -USR2 dunst
