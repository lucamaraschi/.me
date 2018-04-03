#!/usr/bin/env bash

SRC_PATH=~/src/lm
mkdir -p ~/.ssh
mkdir -p ~/src/lm

git clone https://github.com/lucamaraschi/secrets.git $SRC_PATH

git clone https://github.com/lucamaraschi/dotfiles $SRC_PATH

cp secrets/id_rsa* ~/.ssh/

source ~/src/lm/dotfiles/install.sh
