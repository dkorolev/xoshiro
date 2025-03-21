#!/bin/bash

set -e

R1=$(g++ -std=c++17 xoshiro256.cc && ./a.out | md5sum | cut -f1 -d' ')
if [ "$R1" != "c9d58312358dbc51cd8eb553872a3f4d" ] ; then
  echo "C++ fail."
  exit 1
fi
echo "C++ OK."

R2=$(rustc xoshiro256.rs && ./xoshiro256 | md5sum | cut -f1 -d' ')
if [ "$R2" != "c9d58312358dbc51cd8eb553872a3f4d" ] ; then
  echo "Rust fail."
  exit 1
fi
echo "Rust OK."
