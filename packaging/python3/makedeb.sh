#!/bin/bash

gettools="yes"
setup="yes"
cleanup="yes"
pkgfiles=( "build" "changes" "deb" "dsc" "tar.xz" "tar.gz" )


if [ $gettools == "yes" ]; then
    sudo apt-get update && sudo apt-get install build-essential debhelper devscripts dh-make dh-python dput gnupg
    sudo apt-get install python-all python-setuptools python3-all python3-setuptools
    sudo apt-get install i2c-tools libi2c-dev python-dev python3-dev
fi

if [ $setup == "yes" ]; then
    rm -R ../library/build ../library/debian &> /dev/null
    cp -R ./debian/ ../library/
fi

cd ../library && debuild

for file in ${pkgfiles[@]}; do
    mv ../*.$file ../packaging &> /dev/null
done

if [ $cleanup == "yes" ]; then
    debuild clean
    rm -R ./build ./debian &> /dev/null
fi

exit 0
