#!/usr/bin/env bash

SRC_PATH=~/src/lm
mkdir -p ~/.ssh
mkdir -p ~/.aws
mkdir -p $SRC_PATH

git clone https://github.com/lucamaraschi/secrets.git $SRC_PATH/secrets

git clone https://github.com/lucamaraschi/dotfiles $SRC_PATH/dotfiles

cp $SRC_PATH/secrets/id_rsa* ~/.ssh/
sudo chmod 600 ~/.ssh/id_rsa
sudo chmod 600 ~/.ssh/id_rsa.pub

ln -s $SRC_PATH/secrets/aws ~/.aws

cd $SRC_PATH/dotfiles && pwd $SRC_PATH/dotfiles
source $SRC_PATH/dotfiles/install.sh
