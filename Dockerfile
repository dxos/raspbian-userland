FROM golang:1.13

RUN apt-get update \
  && apt-get install -y gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf libssl-dev sudo

RUN wget https://github.com/Kitware/CMake/releases/download/v3.16.4/cmake-3.16.4.tar.gz \
  && tar -xzvf cmake-3.16.4.tar.gz \
  && cd cmake-3.16.4 \
  && ./bootstrap \
  && make -j$(nproc) \
  && make install \
  && cmake --version

ENV BUILDTYPE=Release
ENV BUILDSUBDIR=release
ENV ARM64=OFF
ENV CMAKE_TOOLCHAIN_FILE=../../../makefiles/cmake/toolchains/arm-linux-gnueabihf.cmake

RUN git clone https://github.com/dxos/raspbian_userland.git /rpi-sc \
    && cd /rpi-sc \
    && git checkout 06bc6da \
    && ./buildme /
