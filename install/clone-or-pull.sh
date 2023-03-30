#!/bin/sh
DIR=$2
GIT_URL=$1
GC_ARGS=$3
if [ -d $DIR ]; then
    cd $DIR && git pull --rebase --quiet
else
    git clone --quiet $GC_ARGS $GIT_URL $DIR
fi
