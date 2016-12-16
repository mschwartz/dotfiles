#!/usr/bin/env node

require('shelljs/global')

echo('hello')

if (!test('-d', 'ext')) {
    echo('Must be run in SDK root')
    exit(1)
}

cd('ext')
exec('sencha package build')
cd('../packages')
let pacakge;
for (package of ls('.')) {
    cd(package)
    exec('sencha package build')
    cd('..')
}

