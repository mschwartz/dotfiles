#!/bin/sh

link_sencha_core() {
    cd ext/packages
    ln -sf ../../packages/sencha-core .
}

git pull upstream

cd ext
sencha package build
cd ../packages
for package in `ls`; do
    echo
    echo "BUILDING PACKAGE $package"
    echo
    cd $package
    sencha package build || true
    cd ..
done

cd ..
if [ -e ext/licenses ]; then
    git checkout -- ext/licenses || true
fi

if [ -e packages ]; then
    git checkout -- packages || true
fi

if [ -e ext/examples/kitchensink/device-en.json ]; then
    git checkout -- ext/examples/kitchensink/device-en.json || true
fi

REPO=$1
case $REPO in
    SDK5)
        link_sencha_core
        ln -sf ext extjs
        sencha ant extjs
        ;;
    5)
        link_sencha_core
        ln -sf ext extjs
        sencha ant extjs
        ;;
    5.0)
        link_sencha_core
        ln -sf ext extjs
        sencha ant extjs
        ;;
esac

