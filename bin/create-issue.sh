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
            git checkout sencha-5.0.x
            git pull upstream
            git checkout -b $ISSUE_DIR

            # is this necessary?  sencha ant extjs takes a LONG time to run
#            ln -sf ext extjs
#            sencha ant extjs

#            cd ext
#            sencha package build
#            cd ../packages
#            for package in `ls`; do
#                echo $package
#                cd $package
#                sencha package build
#                cd ..
#            done
            cd $HOME/sencha/projects
            sencha -sdk ../github/$path/ext generate app test $ISSUE_DIR
            cd $ISSUE_DIR
            mv ext xxx
            ln -sf ../../github/$path/ext ext
            cd packages
            for package in `ls ../../../github/$path/packages`; do
                ln -sf ../../../github/$path/packages/$package .
#                cd $package
#                sencha package build
#                cd ..
            done
            cd ..
            sencha app build development
#            cd $HOME/sencha/github/SDK5
#            git checkout -- ext/licenses
#            git checkout -- packages

# fix index.html to load each .js file individually.

cat <<'EOF' >index.html
<!DOCTYPE HTML>
<html manifest="">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

    <title>test</title>

    <link rel="stylesheet" href="bootstrap.css" />
    <!-- The line below must be kept intact for Sencha Cmd to build your application -->
    <!-- <script id="microloader" type="text/javascript" src="bootstrap.js"></script> -->
    <script src="/ext/ext-debug.js"></script>
    <script src="app.js"></script>
</head>
<body></body>
</html>
EOF

# fix app.js so Ext.Loader has the right path for 'test' (the app)
cat <<'EOF' >app.js
/*
 * This file is generated and updated by Sencha Cmd. You can edit this file as
 * needed for your application, but these edits will have to be merged by
 * Sencha Cmd when upgrading.
 */
Ext.Loader.setPath('test', 'app');

Ext.application({
    name: 'test',

    extend: 'test.Application',
    
    autoCreateViewport: 'test.view.main.Main'
	
    //-------------------------------------------------------------------------
    // Most customizations should be made to test.Application. If you need to
    // customize this file, doing so below this section reduces the likelihood
    // of merge conflicts when upgrading to new versions of Sencha Cmd.
    //-------------------------------------------------------------------------
});
EOF

            echo "5.0 complete"
            ;;
        SDK6.0)
            ISSUE_DIR="$ISSUE_ID-6.0"
            git checkout sencha-6.0.x
            git pull upstream
            sencha ant refresh
#            cd ext
#            sencha package build
            cd $HOME/sencha/projects
            sencha -sdk ../github/SDK6.0/ext generate app test $ISSUE_DIR
            cd $ISSUE_DIR
            cd packages
            for package in `ls ../../../github/$path/packages`; do
                ln -sf ../../../github/$path/packages/$package .
#                cd $package
#                sencha package build
#                cd ..
            done
            cd ..
            sencha app build development
            mv ext xxx
            ln -s ../github/$path/ext ext
            echo "6.0 complete"
            ;;
        SDK6.1)
            ISSUE_DIR="$ISSUE_ID-6.1"
            echo git checkout ext-6.1.x
            echo git pull upstream
            echo sencha ant refresh
#            echo cd ext
#            echo sencha package build
            echo cd $HOME/sencha/projects
            echo sencha -sdk ../github/SDK6.1/ext generate app test $ISSUE_DIR
            echo cd $ISSUE_DIR
            echo mv ext xxx
            echo ln -s ../github/$path/ext ext
            cd packages
            for package in `ls ../../../github/$path/packages`; do
                ln -sf ../../../github/$path/packages/$package .
#                cd $package
#                sencha package build
#                cd ..
            done
            cd ..
            sencha app build development
            echo "6.1 complete"
            ;;
        *)
            echo "Unknown version $path"
    esac
done   # for path in repos

