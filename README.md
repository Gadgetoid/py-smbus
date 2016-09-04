# Introduction

Python SMBUS is a Python bindings for Linux SMBus access through i2c-dev.

This repository contains the sources for py-smbus extracted from the i2c-tools project previously hosted at http://lm-sensors.org/svn/i2c-tools.

The primary goal is to host the sources in a sane location, and providing adequate packaging instructions for various versions of Python.

I am well aware that multiple github repositories have been created with a similar purpose in mind, but the focus of this repo will be on providing working deb packages for the Raspberry Pi specifically.

As such, while building instructions for deploying the library locally are provided (and therefore no architecture or environment limitations should exist), the debian packages provided herein will be strictly aimed at the armhf arch.

# Pre-requisites

```
sudo apt-get install i2c-tools libi2c-dev python-dev python3-dev
```

# Installation

```
python2 setup.py build
sudo python2 setup.py install
```

or:

```
python3 setup.py build
sudo python3 setup.py install
```

# Original README

To build:
```
$ python setup.py build
```

On most GNU/Linux distributions, you'll need to install the python-devel
package for the build to succeed.

To install (will also build if necessary):
```
$ python setup.py install
```

For general build/install help:

```
$ python setup.py --help-commands
```

Frequently Answered Question:

Q: It's throwing exceptions, nothing works, what's wrong?

    A1: You need write permissions to the i2c-dev devices.  Try running as root.

    A2: Addresses in Linux/I2C are the most-sig 7 bits, right-justified.  E.g.
    if your device uses address 0xc0 to write and 0xc1 to read, then use
    address 0x60 with this module.

    A3: Some other kernel driver has claimed that I2C address.  Unload it first.
