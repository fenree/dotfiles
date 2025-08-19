#!/bin/sh
export CC=musl-gcc

[ -d libxcrypt ] || git clone https://github.com/besser82/libxcrypt
cd libxcrypt
[ -f configure ] || ./autogen.sh
make clean && ./configure --enable-static
make -j4
su -c 'make install'
cd ..
make clean && ./configure --without-pam --enable-static
make -j4
su -c 'make install'
