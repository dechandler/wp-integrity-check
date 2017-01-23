#!/bin/bash
start_pwd=$PWD

TMP_DIR=$HOME/src/wp-integrity-check
mkdir $TMP_DIR/wp-hashes
mkdir $TMP_DIR/wp

./get-wp-versions.py | \
while read _v; do
    cd $TMP_DIR/wp
    _url="https://wordpress.org/wordpress-$_v.tar.gz"
    tar xzf <(wget -qO- "$_url") || continue;
    _wpdir="$TMP_DIR/wp/$(ls $TMP_DIR/wp)"
    cd $_wpdir
    find -type f -exec md5sum {} \; > $TMP_DIR/wp-hashes/$_v
    cd "$TMP_DIR/wp"
    rm -rf "$_wpdir"
done

rmdir $TMP_DIR/wp

cd $start_pwd
