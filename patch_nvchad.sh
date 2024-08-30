#!/bin/zsh

CHADRC_PATH='/.config/nvim/lua/chadrc.lua'

if [[ "$(basename "$(pwd)")" == "dotfiles" ]]; then
    cp ./$CHADRC_PATH $HOME/$CHADRC_PATH
    echo "done"
else
    echo "error: this script must be ran from dotfiles repository"
fi