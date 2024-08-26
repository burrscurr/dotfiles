#!/bin/sh
APT_NAME=$1
BREW_NAME=$2

if type "apt-get" > /dev/null 2>&1 && apt-cache show ${APT_NAME} > /dev/null 2>&1; then
    echo "sudo apt-get install -y ${APT_NAME}"
    sudo apt-get install -y ${APT_NAME};
elif type "brew" > /dev/null; then
    echo "brew install ${BREW_NAME}"
    brew install ${BREW_NAME};
else
    echo "Don't know how to install package $APT_NAME / $BREW_NAME." 1>&2
    exit 1;
fi
