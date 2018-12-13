#!/usr/bin/env bash

SRC_PATH=~/src/lm
mkdir -p ~/.ssh
mkdir -p ~/.aws
mkdir -p $SRC_PATH

if test ! $(which brew); then
	echo "Installing homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

sudo xcodebuild -license accept
echo "Xcode CLI tools OK"

git clone https://github.com/lucamaraschi/secrets.git $SRC_PATH/secrets

git clone https://github.com/lucamaraschi/dotfiles $SRC_PATH/dotfiles

mkdir -p ~/.ssh
cp $SRC_PATH/secrets/id_rsa* ~/.ssh/
sudo chmod 600 ~/.ssh/id_rsa
sudo chmod 600 ~/.ssh/id_rsa.pub

mkdir -p ~/.aws
ln -s $SRC_PATH/secrets/aws ~/.aws

cd $SRC_PATH/dotfiles && pwd $SRC_PATH/dotfiles
source $SRC_PATH/dotfiles/install.sh
