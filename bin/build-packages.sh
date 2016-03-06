#!/bin/sh

link_sencha_core() {
    cd ext/packages
    ln -sf ../../packages/sencha-core .
}

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
git checkout -- ext/licenses
git checkout -- packages
git checkout -- ext/examples/kitchensink/device-en.json

REPO=$1
case $REPO in
    SDK5)
        link_sencha_core
        ;;
    5)
        link_sencha_core
        ;;
    5.0)
        link_sencha_core
        ;;
esac

