#!/bin/sh

# comment in to enable echo of commands to console
#set -x

. $HOME/bin/sencha-git-common.inc

echo "Processing: ISSUE_ID=$ISSUE_ID REPOS=$REPOS"

for path in $REPOS; do
    cd $HOME/sencha/github/$path
    case $path in
        SDK5)
            ISSUE_DIR="$ISSUE_ID-5.0"
            git checkout sencha-5.0.x || true
            git branch -D $ISSUE_DIR || true
            ;;
        SDK6.0)
            ISSUE_DIR="$ISSUE_ID-6.0"
            git checkout sencha-6.0.x || true
            git branch -D $ISSUE_DIR || true
            ;;
        SDK6.1)
            ISSUE_DIR="$ISSUE_ID-6.1"
            git checkout ext-6.1.x || true
            git branch -D $ISSUE_DIR || true
            ;;
        *)
            echo "Unknown version $path"
            exit 1
    esac
    cd $HOME/sencha/projects
    mkdir archive
    mv $ISSUE_DIR archive/ || true
    echo "$path complete"
done

