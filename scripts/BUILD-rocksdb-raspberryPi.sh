#!/bin/sh

# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-armhf

#export CROSS_COMPILE=aarch64-linux-gnu-
export CROSS_COMPILE=arm-linux-gnueabihf-

# not specific to Cavium ThunderX
# ARCH_FLAGS="-march=armv8-a+crc+crypto -mtune=thunderx"
ARCH_FLAGS="-march=native -mtune=native"

set -x
make \
  CC=${CROSS_COMPILE}gcc \
  CXX=${CROSS_COMPILE}g++ \
  AR=${CROSS_COMPILE}ar \
  STRIP=${CROSS_COMPILE}strip \
  EXTRA_CFLAGS="${ARCH_FLAGS} -fuse-ld=gold" \
  EXTRA_CXXFLAGS="${ARCH_FLAGS} -static-libstdc++ -fuse-ld=gold" \
  EXTRA_LDFLAGS="-Wl,-Bsymbolic-functions -Wl,--icf=all" \
  DEBUG_LEVEL=0 \
rocksdbjavastatic -j4
