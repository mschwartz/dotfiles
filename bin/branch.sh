#!/bin/sh

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

for path in $REPOS; do
    cd $HOME/sencha/github/$path
    case $path in 
        SDK6.2)
            git checkout ext-6.2.x
            git checkout -b $ISSUE_ID || git checkout $ISSUE_ID
            git pull upstream ext-6.2.x
            ;;
        *)
            echo "Unknown SDK  $path"
    esac        
done


