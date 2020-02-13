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

# check if user has git installed and propose to install if not installed
if [ "$(which git)" ]; then
        echo "You already have git. Exiting.."
else
        XCODE_MESSAGE="$(osascript -e 'tell app "System Events" to display dialog "Please click install when Command Line Developer Tools appears"')"
        if [ "$XCODE_MESSAGE" = "button returned:OK" ]; then
            xcode-select --install
        else
            echo "You have cancelled the installation, please rerun the installer."
            # you have forgotten to exit here
            exit
        fi
fi

until [ "$(which git)" ]; do
        echo -n "."
        sleep 1
done
echo ""

echo "Xcode CLI tools OK"

git clone https://github.com/lucamaraschi/secrets.git $SRC_PATH/secrets

git clone https://github.com/lucamaraschi/dotfiles -b 2.0 $SRC_PATH/dotfiles

mkdir -p ~/.ssh
cp $SRC_PATH/secrets/id_rsa* ~/.ssh/
sudo chmod 600 ~/.ssh/id_rsa
sudo chmod 600 ~/.ssh/id_rsa.pub

ln -s $SRC_PATH/secrets/aws ~/.aws

cd $SRC_PATH/dotfiles && pwd $SRC_PATH/dotfiles
source $SRC_PATH/dotfiles/install.sh
