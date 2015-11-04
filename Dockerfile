FROM qbbproject/archlinux-base

MAINTAINER Christopher Hinz <hinz@theo-physik.uni-kiel.de>

RUN pacman --noconfirm -Sy archlinux-keyring && pacman --noconfirm -Syu && pacman-db-upgrade && sudo paccache -k 0 -r -v # rev 5

RUN groupadd -g 1000 gitlab && useradd -m -u 1002 -g gitlab -G wheel -s /bin/bash gitlab

RUN mkdir -p /builds && chown gitlab /builds

USER gitlab

RUN cd /tmp && curl -O https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz && tar -xvzf package-query.tar.gz && cd package-query && makepkg --noconfirm -si
RUN cd /tmp && curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz && tar -xvzf yaourt.tar.gz && cd yaourt && makepkg --noconfirm -si

RUN yaourt --noconfirm -Syu boost yaml-cpp cmake gperftools llvm clang hwloc jemalloc hdf5 gtest git eigen python-sphinx doxygen graphviz ttf-dejavu openssh 
&& sudo paccache -k 0 -r -v # rev 1

COPY packages /tmp/packages

RUN cp -r /tmp/packages/hpx /tmp/hpx && cd /tmp/hpx && makepkg --noconfirm -si && cp -r /tmp/packages/isl /tmp/isl && cd /tmp/isl && makepkg --noconfirm -si && sudo rm -r /tmp/*
