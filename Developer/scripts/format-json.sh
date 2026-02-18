#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title format clipboard json
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖋️

# Documentation:
# @raycast.description format clipboard json and copy to clipboard
# @raycast.author collin murch
# @raycast.authorURL https://collinmurch.com

caller=$(ps -o comm= $PPID)
if [[ "$caller" == *"Raycast" ]]; then
    pbpaste | jq | pbcopy
else
    cat - | jq
fi
