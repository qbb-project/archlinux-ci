FROM qbbproject/archlinux-base

LABEL revision="9"

MAINTAINER Christopher Hinz <hinz@theo-physik.uni-kiel.de>

RUN yaourt --noconfirm -Syua boost yaml-cpp cmake gperftools llvm clang hwloc jemalloc isl hdf5 gtest git eigen python-sphinx doxygen graphviz ttf-dejavu openssh rsync && sudo paccache -k 0 -r -v

COPY packages /tmp/packages

RUN cp -r /tmp/packages/hpx /tmp/hpx && cd /tmp/hpx && makepkg --noconfirm -si && sudo rm -r /tmp/*
