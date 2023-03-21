#!/bin/sh
APT_NAME=$1
BREW_NAME=$2
CARGO_NAME=$3

# Use apt-get just if the package is actually available.
if type "apt-get" > /dev/null 2>&1 && apt-cache show ${APT_NAME} 2>&1 | grep -v "No packages found"; then
    echo "sudo apt-get install -y ${APT_NAME}"
    sudo apt-get install -y ${APT_NAME};
elif type "brew" > /dev/null; then
    echo "brew install ${BREW_NAME}"
    brew install ${BREW_NAME};
else
    echo "cargo install ${CARGO_NAME}"
    cargo install ${CARGO_NAME};
fi
