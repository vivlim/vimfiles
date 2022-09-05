#!/bin/sh

MYVIMRC=./init.vim nvim -u ./init.vim --cmd ":set runtimepath+=`pwd`"
