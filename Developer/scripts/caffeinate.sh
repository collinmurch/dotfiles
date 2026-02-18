#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title caffeinate
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ☕

# Documentation:
# @raycast.description toggle caffeination status
# @raycast.author collin murch
# @raycast.authorURL https://collinmurch.com

if pgrep -x "caffeinate" > /dev/null; then
    killall caffeinate
    echo "no longer caffeinated"
else
    /usr/bin/caffeinate -i &
    echo "caffeinated ☕"
fi
