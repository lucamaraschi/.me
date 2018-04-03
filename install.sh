#!/usr/bin/env bash

SRC_PATH=~/src/lm
mkdir -p ~/.ssh
mkdir -p $SRC_PATH

git clone https://github.com/lucamaraschi/secrets.git $SRC_PATH/secrets

git clone https://github.com/lucamaraschi/dotfiles $SRC_PATH/dotfiles

cp $SRC_PATH/secrets/id_rsa* ~/.ssh/

source $SRC_PATH/dotfiles/install.sh
