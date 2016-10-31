#!/bin/sh

if [ "$1" == "" ]; then
    echo "Usage: $0 issue-id [sdk-version(s)]"
    exit 1
fi

ISSUE_ID=$1
shift

if [ "$1" == "" ]; then
    REPOS="SDK7.0"
    BRANCH="ext-7.0.x"
else
    REPOS=""
    while [ "$1" ]
    do
        REPO=$1
        case $REPO in
            SDK5)
                REPO="SDK5.x"
                BRANCH="ext-5.0.x"
                ;;
            5)
                REPO="SDK5.x"
                BRANCH="ext-5.0.x"
                ;;
            5.0)
                REPO="SDK5.x"
                BRANCH="ext-5.0.x"
                ;;
            SDK6)
                REPO="SDK6.2"
                BRANCH="ext-6.2.x"
                ;;
            SDK6.2)
                REPO="SDK6.0"
                BRANCH="ext-6.2.x"
                ;;
            6)
                REPO="SDK6.2"
                BRANCH="ext-6.2.x"
                ;;
            6.2)
                REPO="SDK6.2"
                BRANCH="ext-6.2.x"
                ;;
            SDK6.2)
                REPO="SDK6.2"
                BRANCH="ext-6.2.x"
                ;;
            6.2)
                REPO="SDK6.2"
                BRANCH="ext-6.2.x"
                ;;
            7)
                REPO="SDK7.0"
                BRANCH="ext-7.0.x"
                ;;
            SDK7.0)
                REPO="SDK7.0"
                BRANCH="ext-7.0.x"
                ;;
            7.0)
                REPO="SDK7.0"
                BRANCH="ext-7.0.x"
                ;;
        esac
        if [ -z $REPOS ]; then
            REPOS=$REPO
        else
            REPOS="$REPOS $REPO"
        fi
        shift
    done
fi


