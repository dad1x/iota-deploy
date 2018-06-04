#!/bin/bash

DIR_ROCKSDB="rocksdb"
REPO_ROCKSDB="https://github.com/jserv/rocksdb.git"
DIR_SNAPPY="snappy"
REPO_SNAPPY="https://github.com/google/snappy.git"
VER_SNAPPY="1.1.4"

# Specific RocksDB architecture to deploy
if [ "$1" == "" ]; then
    echo "Usage: ./BUILD-rocksdb.sh [the rocksDB architecture you want to build (arm32/arm64/x8664)]"
    exit 1
fi

# Clone RocksDB
if [[ ! -e $DIR_ROCKSDB ]]; then
    sudo apt-get -y install openjdk-8-jdk-headless
    sudo apt-get -y install autotools-dev
    sudo apt-get -y install automake
    git clone $REPO_ROCKSDB 
fi


# Copy Platform script
if [ "$1" == "arm32" ]; then
    echo "Copying files for Arm32 ..."
    cp iota-deploy/scripts/rocksdb/BUILD-rocksdb-armv7.sh $DIR_ROCKSDB/BUILD.sh
    cp iota-deploy/scripts/rocksdb/DEPLOY_MAVEN-rocksdb-armv7.sh $DIR_ROCKSDB/DEPLOY_MAVEN.sh
    cp iota-deploy/scripts/rocksdb/Makefile $DIR_ROCKSDB
    cp -rf $DIR_SNAPPY-$VER_SNAPPY $DIR_ROCKSDB
    # Clone libsnappy
    cd $DIR_ROCKSDB
    git clone https://github.com/yillkid/snappy-1.1.4.git
fi

# Build RocksDB
cd $DIR_ROCKSDB
./BUILD.sh
./DEPLOY_MAVEN.sh
