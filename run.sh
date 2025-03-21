#!/bin/bash

set -e

MD5=$(echo | md5 >/dev/null 2>&1 && echo md5 || echo md5sum)

R1=$(g++ -std=c++17 xoshiro256.cc && ./a.out | $MD5 | cut -f1 -d' ')
if [ "$R1" != "c9d58312358dbc51cd8eb553872a3f4d" ] ; then
  echo "C++ fail."
  exit 1
fi
echo "C++ OK."

R2=$(rustc xoshiro256.rs && ./xoshiro256 | $MD5 | cut -f1 -d' ')
if [ "$R2" != "c9d58312358dbc51cd8eb553872a3f4d" ] ; then
  echo "Rust fail."
  exit 1
fi
echo "Rust OK."
