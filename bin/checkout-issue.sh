#!/bin/sh

# comment in to enable echo of commands to console
#set -x

. $HOME/bin/sencha-git-common.inc

for path in $REPOS; do
    cd $HOME/sencha/github/$path
    git diff --exit-code
    rc=$?
    if [ "$rc" == "1" ]; then
        echo "$path repo has changes that need your attention"
        exit 1
    fi
done

echo "Processing: ISSUE_ID=$ISSUE_ID REPOS=$REPOS"

for path in $REPOS; do
    cd $HOME/sencha/github/$path
    case $path in
        SDK5)
            ISSUE_DIR="$ISSUE_ID-5.0"
            git checkout $ISSUE_DIR
            echo "5.0 complete"
            ;;
        SDK6.0)
            ISSUE_DIR="$ISSUE_ID-6.0"
            git checkout $ISSUE_DIR
            sencha ant refresh
            echo "6.0 complete"
            ;;
        SDK6.1)
            ISSUE_DIR="$ISSUE_ID-6.1"
            git checkout $ISSUE_DIR
            sencha ant refresh
            echo "6.1 complete"
            ;;
        *)
            echo "Unknown version $path"
    esac
done   # for path in repos

