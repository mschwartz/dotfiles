#!/bin/sh

# comment in to enable echo of commands to console
#set -x

. $HOME/bin/sencha-git-common.inc

echo "Processing: ISSUE_ID=$ISSUE_ID REPOS=$REPOS"

for path in $REPOS; do
    cd $HOME/sencha/github/$path
    case $path in
        SDK5.x)
            ISSUE_DIR="$ISSUE_ID-5.x"
            git checkout sencha-5.0.x || true
            git branch -D $ISSUE_DIR || true
            git push origin --delete $ISSUE_DIR
            ;;
        SDK6.0)
            ISSUE_DIR="$ISSUE_ID-6.0"
            git checkout sencha-6.0.x || true
            git branch -D $ISSUE_DIR || true
            git push origin --delete $ISSUE_DIR
            ;;
        SDK6.2)
            ISSUE_DIR="$ISSUE_ID-6.2"
            git checkout ext-6.2.x || true
            git branch -D $ISSUE_DIR || true
            git push origin --delete $ISSUE_DIR
            ;;
        *)
            echo "Unknown version $path"
            exit 1
    esac
    cd $HOME/sencha/projects
    mkdir -p archive
    mv $ISSUE_DIR archive/ || true
    echo "$path complete"
done

