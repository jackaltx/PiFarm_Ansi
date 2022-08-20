#!/bin/sh
cd /tmp/
wget http://www.iozone.org/src/current/iozone3_493.tgz
tar -xz xvf iozone3_493.tgz
cd iozone3_493/src/current
make
make linux
