#!/bin/bash

gettools="yes"
setup="yes"
build="yes"
cleanup="yes"
origtar="py-smbus_1.1+34m.orig.tar.gz"
pkgfiles=( "build" "changes" "deb" "dsc" "tar.xz" "tar.gz" )

if [ $gettools == "yes" ]; then
    sudo apt-get update
    sudo apt-get install -y build-essential
    sudo apt-get install -y debhelper devscripts
    sudo apt-get install -y dh-make dh-python
    sudo apt-get install -y python-all-dev python-setuptools
    sudo apt-get install -y python3-all-dev python3-setuptools
    sudo apt-get install -y gnupg i2c-tools libi2c-dev
fi

if [ $setup == "yes" ]; then
    rm -R ../../library/build ../../library/debian &> /dev/null
    cp -R ./debian/ ../../library/
    cp -R ./$origtar ../../
fi

if [ $build == "yes" ]; then
    cd ../../library && debuild

    for file in ${pkgfiles[@]}; do
        mv ../*.$file ../packaging/python3 &> /dev/null
    done
fi

if [ $cleanup == "yes" ]; then
    debuild clean
    rm -R ./build ./debian &> /dev/null
fi

exit 0
