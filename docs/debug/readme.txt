add-auto-load-safe-path  /home/vpopov/projects/t113/buildroot-2022.08-t113/output/host/arm-buildroot-linux-gnueabihf/sysroot/lib/libstdc++.so.6.0.28-gdb.py 

/home/vpopov/projects/t113/buildroot-2022.08-t113/output/host/arm-buildroot-linux-gnueabihf/sysroot

CONFIG(debug, debug|release) {
    QMAKE_CXXFLAGS -= -g0
    QMAKE_CXXFLAGS += -g
}
