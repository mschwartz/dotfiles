#!/bin/sh

if [ "$1" == "" ]; then
    echo "Usage: $0 issue-id [sdk-version(s)]"
    exit 1
fi

ISSUE_ID=$1
shift

if [ "$1" == "" ]; then
    REPOS="SDK6.1"
else
    REPOS=""
    while [ "$1" ]
    do
        REPO=$1
        case $REPO in
            SDK5)
                REPO="SDK5"
                ;;
            5)
                REPO="SDK5"
                ;;
            5.0)
                REPO="SDK5"
                ;;
            SDK6)
                REPO="SDK6.0"
                ;;
            SDK6.0)
                REPO="SDK6.0"
                ;;
            6)
                REPO="SDK6.0"
                ;;
            6.0)
                REPO="SDK6.0"
                ;;
            SDK6.1)
                REPO="SDK6.1"
                ;;
            6.1)
                REPO="SDK6.1"
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


