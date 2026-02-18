#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title format to plain text
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📋

# Documentation:
# @raycast.description format clipboard as plain text
# @raycast.author Collin Murch
# @raycast.authorURL https://collinmurch.com

caller=$(ps -o comm= $PPID)
if [[ "$caller" == *"Raycast" ]]; then
    pbpaste | textutil -convert txt -stdin -stdout -encoding UTF-8 | pbcopy
else
    cat - | textutil -convert txt -stdin -stdout -encoding UTF-8
fi
