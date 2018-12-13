#!/usr/bin/env bash

SRC_PATH=~/src/lm
mkdir -p ~/.ssh
mkdir -p ~/.aws
mkdir -p $SRC_PATH

if [ ! "$(which git)" ]; then
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

echo 'Xcode has finished installing'

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
