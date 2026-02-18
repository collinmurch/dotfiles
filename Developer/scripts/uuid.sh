#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title uuid
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🪪

# Documentation:
# @raycast.description copy a uuid
# @raycast.author collin murch
# @raycast.authorURL https://collinmurch.com

caller=$(ps -o comm= $PPID)
if [[ "$caller" == *"Raycast" ]]; then
    uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n' | tee >(pbcopy)
else
    uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n'
fi
