#!/usr/bin/env bash

SRC_PATH=~/src/lm
mkdir -p ~/.ssh
mkdir -p $SRC_PATH

sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if test ! $(which brew); then
	echo "Installing homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

sudo xcodebuild -license accept
echo "Xcode CLI tools OK"

[ -d "$SRC_PATH/secrets" ] && echo "Directory $SRC_PATH/secrets exists. Deleteling existing one" && rm -rf $SRC_PATH/secrets
git clone https://github.com/lucamaraschi/secrets.git $SRC_PATH/secrets

[ -d "$SRC_PATH/dotfiles" ] && echo "Directory $SRC_PATH/dotfiles exists. Deleteling existing one" && rm -rf $SRC_PATH/dotfiles
git clone --branch 2.0 https://github.com/lucamaraschi/dotfiles $SRC_PATH/dotfiles

mkdir -p ~/.ssh
cp $SRC_PATH/secrets/id_rsa* ~/.ssh/
sudo chmod 600 ~/.ssh/id_rsa
sudo chmod 600 ~/.ssh/id_rsa.pub

ln -s $SRC_PATH/secrets/aws ~/.aws

cd $SRC_PATH/dotfiles && pwd $SRC_PATH/dotfiles
source $SRC_PATH/dotfiles/install.sh
