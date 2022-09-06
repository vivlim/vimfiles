#!/usr/bin/env bash

SCRIPT_DIR="$( dirname -- "$0"; )"

MYVIMRC=$SCRIPT_DIR/init.vim nvim -u $SCRIPT_DIR/init.vim --cmd ":set runtimepath+=$SCRIPT_DIR" $@
