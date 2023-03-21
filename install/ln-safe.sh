#!/bin/sh
GIT_FILE=$1
SYMLINK=$2
EVACUATED=$SYMLINK.evacuated
# To avoid ln -f overwriting an existing file that isn't symlinked, export it first.
if [ -f $SYMLINK ]; then
    if ! [ -L $SYMLINK ]; then
        echo "    There already is a file at \`$SYMLINK\`.";
        mv $SYMLINK $EVACUATED;
    fi
fi
ln -sf $GIT_FILE $SYMLINK;
# Preserve the symlink as well as the original file content by tracking it with git.
if [ -f $EVACUATED ]; then
    # Don't override uncommited changes (if there are any).
    if git status --porcelain=v1 $GIT_FILE | grep -q "M "; then
        echo "    Cannot track original file with \`git\` since the version in the repository has uncommited changes.";
        echo "    The original file was moved to \`$EVACUATED\`.";
    else
        mv $EVACUATED $GIT_FILE;
        echo "    The originial file is now tracked with \`git\`. Use \`git diff $GIT_FILE\` to compare the intended version with the existing version.";
    fi
fi
