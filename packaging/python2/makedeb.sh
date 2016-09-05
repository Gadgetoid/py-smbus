#!/bin/bash

gettools="yes"
setup="yes"
build="yes"
cleanup="yes"
pkgfiles=( "build" "changes" "deb" "dsc" "tar.xz" "tar.gz" )

if [ $gettools == "yes" ]; then
    sudo apt-get update
    sudo apt-get install build-essential
    sudo apt-get install debhelper devscripts
    sudo apt-get install dh-make dh-python
    sudo apt-get install python-dev python-setuptools
    sudo apt-get install python3-dev python3-setuptools
    sudo apt-get install gnupg i2c-tools libi2c-dev
fi

if [ $setup == "yes" ]; then
    rm -R ../../library/build ../../library/debian &> /dev/null
    cp -R ./debian/ ../../library/
fi

if [ $build == "yes" ]; then
    cd ../../library && debuild

    for file in ${pkgfiles[@]}; do
        mv ../*.$file ../packaging/python2 &> /dev/null
    done
fi

if [ $cleanup == "yes" ]; then
    debuild clean
    rm -R ./build ./debian &> /dev/null
fi

exit 0
