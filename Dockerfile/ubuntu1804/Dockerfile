FROM ubuntu:18.04

ENV CC clang-9
ENV CXX clang++-9
ENV CXXFLAGS -std=c++11
ENV RUNTIME_VERSION gnustep-2.0
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig
ENV LD /usr/bin/ld.gold
ENV LDFLAGS "-fuse-ld=/usr/bin/ld.gold -L/usr/local/lib"

WORKDIR /GNUstep-build

RUN set -x \
  && apt update \
  && apt upgrade -y \
  && apt install -y git sudo clang-9 clang++-9 build-essential wget \
    subversion cmake libffi-dev libxml2-dev \
    libgnutls28-dev libicu-dev libblocksruntime-dev libkqueue-dev libpthread-workqueue-dev autoconf libtool \
    libjpeg-dev libtiff-dev libffi-dev libcairo-dev libx11-dev libxt-dev libxft-dev \
  && apt autoremove -y \
  && apt clean \
  && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Build GNUstep make
RUN set -x \
    #
    # Checkout tools-make
    && git clone https://github.com/gnustep/tools-make.git \
    #
    # Build GNUstep make
    && cd tools-make \
    && CC=${CC} ./configure \
            --with-layout=gnustep \
            --disable-importing-config-file \
            --enable-native-objc-exceptions \
            --enable-objc-arc \
            --enable-install-ld-so-conf \
            --with-library-combo=ng-gnu-gnu \
    && make -j8 \
    && sudo -E make install \
    && . /usr/GNUstep/System/Library/Makefiles/GNUstep.sh \
    && echo ". /usr/GNUstep/System/Library/Makefiles/GNUstep.sh" >> ~/.bashrc \
    && echo "export RUNTIME_VERSION=gnustep-2.0" >> ~/.bashrc \
    && echo 'export CXXFLAGS="-std=c++11"' >> ~/.bashrc \
    && cd .. \
#
# Build libdispatch
    #
    # Checkout swift-corelibs-libdispatch
    && git clone https://github.com/apple/swift-corelibs-libdispatch \
    && cd swift-corelibs-libdispatch \
    && git checkout swift-5.1.1-RELEASE \
    #
    # Build libdispatch
    && rm -Rf build \
    && mkdir build \
    && cd build \
    && cmake .. \
         -DCMAKE_C_COMPILER=${CC} \
         -DCMAKE_CXX_COMPILER=${CXX} \
         -DCMAKE_BUILD_TYPE=Release \
         -DUSE_GOLD_LINKER=YES \
    && make \
    && sudo -E make install \
    && sudo ldconfig \
    && cd ../.. \
#
# Build libobjc2
    #
    # Checkout libobjc2
    && git clone https://github.com/gnustep/libobjc2.git \
    && cd libobjc2 \
    && git submodule init \
    && git submodule sync \
    && git submodule update \
    #
    # Build libobjc2
    && rm -Rf build \
    && mkdir build \
    && cd build \
    && cmake .. \
         -DCMAKE_C_COMPILER=${CC} \
         -DCMAKE_CXX_COMPILER=${CXX} \
         -DCMAKE_ASM_COMPILER=${CC} \
         -DTESTS=OFF \
    && cmake --build . \
    && sudo -E make install \
    && sudo ldconfig \
    && cd ../.. \
#
# Build GNUstep make second time
    && cd tools-make \
    && CC=${CC} ./configure \
            --with-layout=gnustep \
            --disable-importing-config-file \
            --enable-native-objc-exceptions \
            --enable-objc-arc \
            --enable-install-ld-so-conf \
            --with-library-combo=ng-gnu-gnu \
    && make -j8 \
    && sudo -E make install \
    && . /usr/GNUstep/System/Library/Makefiles/GNUstep.sh \
    && cd .. \
#
# Build GNUstep base
    #
    # Checkout libs-base
    && git clone https://github.com/gnustep/libs-base.git \
    #
    # Build GNUstep base
    && cd libs-base \
    && ./configure \
    && make -j8 \
    && sudo -E make install \
    && cd ..

# For GUI programming
#
# Build GNUstep GUI Library
RUN set -x \
    && . /usr/GNUstep/System/Library/Makefiles/GNUstep.sh \
    #
    # Checkout libs-gui
    && git clone https://github.com/gnustep/libs-gui.git \
    #
    # Build GNUstep GUI Library
    && cd libs-gui \
    && ./configure \
    && make -j8 \
    && sudo -E make install \
    && cd .. \
#
# Build GNUstep GUI Backend
    #
    # Checkout libs-back
    && git clone https://github.com/gnustep/libs-back.git \
    #
    # Build GNUstep GUI Backend
    && cd libs-back \
    && ./configure \
    && make -j8 \
    && sudo -E make install \
    && cd ..

WORKDIR /workdir

# Clean build directory
RUN rm -rf /GNUstep-build

# Set alias
RUN echo 'alias clang-objc="\${CC} \$(gnustep-config --objc-flags) \$(gnustep-config --objc-libs) -fobjc-arc -lobjc -ldispatch -lgnustep-base"' >> ~/.bashrc

CMD ["/bin/bash"]
