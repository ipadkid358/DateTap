#!/bin/bash

make ARCHS=x86_64 TARGET=simulator:clang::latest DEBUG=0

# for reasons unknown, if the original dylibs aren't manually deleted, the simulator things the new binaries have invalid signatures
rm /opt/simject/DateTapKit.dylib
rm /opt/simject/DateTapSpring.dylib

cp .theos/obj/iphone_simulator/DateTapKit.dylib /opt/simject/
cp .theos/obj/iphone_simulator/DateTapSpring.dylib /opt/simject/

~/Desktop/simject/bin/respring_simulator
