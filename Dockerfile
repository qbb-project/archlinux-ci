FROM qbbproject/archlinux-base

LABEL revision="1"

MAINTAINER Christopher Hinz <hinz@theo-physik.uni-kiel.de>

RUN yaourt --noconfirm -Syu boost yaml-cpp cmake gperftools llvm clang hwloc jemalloc hdf5 gtest git eigen python-sphinx doxygen graphviz ttf-dejavu openssh && sudo paccache -k 0 -r -v

COPY packages /tmp/packages

RUN cp -r /tmp/packages/hpx /tmp/hpx && cd /tmp/hpx && makepkg --noconfirm -si && cp -r /tmp/packages/isl /tmp/isl && cd /tmp/isl && makepkg --noconfirm -si && sudo rm -r /tmp/*
