#!/bin/bash

# To update:
# code --list-extensions > extensions_vscode.txt

cat extensions_vscode.txt | while read extension || [[ -n $extension ]];
do
  code --install-extension $extension --force
done