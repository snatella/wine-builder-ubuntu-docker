FROM ubuntu:18.04 AS BUILD64
ENV build_cores 6
ARG http_proxy
ENV http_proxy=${http_proxy}
ENV https_proxy=${http_proxy}

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install git ccache libvulkan-dev libvulkan-dev:i386 gcc-multilib pigz -y \
    && apt-get build-dep wine -y \
    && apt-get build-dep wine-development -y \
    && apt-get install comerr-dev:i386 freeglut3-dev:i386 krb5-multidev:i386 libasound2-dev:i386 libcapi20-dev:i386 libcups2-dev:i386 libcupsimage2-dev:i386 libdbus-1-dev:i386 libdrm-dev:i386 libegl1-mesa-dev:i386 libexif-dev:i386 libexpat1-dev:i386 libfontconfig1-dev:i386 libfreetype6-dev:i386 libgettextpo-dev:i386 libgl1-mesa-dev:i386 libgles2-mesa-dev:i386 libglib2.0-dev:i386 libglib2.0-dev-bin:i386 libglu1-mesa-dev:i386 libglvnd-core-dev:i386 libglvnd-dev:i386 libgmp-dev:i386 libgnutls28-dev:i386 libgphoto2-dev:i386 libgraphite2-dev:i386 libgsm1-dev:i386 libgstreamer-plugins-base1.0-dev:i386 libgstreamer1.0-dev:i386 libgudev-1.0-0:i386 libharfbuzz-dev:i386 libice-dev:i386 libicu-dev:i386 libicu-le-hb-dev:i386 libidn2-0-dev:i386 libidn2-dev:i386 libjbig-dev:i386 libjpeg-dev:i386 libjpeg-turbo8-dev:i386 libjpeg8-dev:i386 libkrb5-dev:i386 liblcms2-dev:i386 libldap2-dev:i386 libltdl-dev:i386 liblzma-dev:i386 libmpg123-dev:i386 libncurses5-dev:i386 libopenal-dev:i386 liborc-0.4-dev:i386 liborc-0.4-dev-bin:i386 libosmesa6-dev:i386 libp11-kit-dev:i386 libpcap0.8-dev:i386 libpcre3-dev:i386 libpng-dev:i386 libpthread-stubs0-dev:i386 libpulse-dev:i386 libsane-dev:i386 libsm-dev:i386 libssl-dev:i386 libstdc++-7-dev:i386 libtasn1-6-dev:i386 libtiff-dev:i386 libtiff5-dev:i386 libtinfo-dev:i386 libudev-dev:i386 libv4l-dev:i386 libwayland-dev:i386 libx11-dev:i386 libx11-xcb-dev:i386 libxau-dev:i386 libxcb-dri2-0-dev:i386 libxcb-dri3-dev:i386 libxcb-glx0-dev:i386 libxcb-present-dev:i386 libxcb-randr0-dev:i386 libxcb-render0-dev:i386 libxcb-shape0-dev:i386 libxcb-sync-dev:i386 libxcb-xfixes0-dev:i386 libxcb1-dev:i386 libxcomposite-dev:i386 libxcursor-dev:i386 libxdamage-dev:i386 libxdmcp-dev:i386 libxext-dev:i386 libxfixes-dev:i386 libxi-dev:i386 libxinerama-dev:i386 libxkbfile-dev:i386 libxml2-dev:i386 libxmu-dev:i386 libxrandr-dev:i386 libxrender-dev:i386 libxshmfence-dev:i386 libxslt1-dev:i386 libxt-dev:i386 libxxf86dga-dev:i386 libxxf86vm-dev:i386 linux-libc-dev:i386 mesa-common-dev:i386 nettle-dev:i386 ocl-icd-opencl-dev:i386 udev:i386 unixodbc-dev:i386 x11proto-dev:i386 xtrans-dev:i386 zlib1g-dev:i386 libusb-dev:i386 -y \
    && /usr/sbin/update-ccache-symlinks

COPY container-scripts/build.sh /usr/bin/build.sh

RUN chmod +x /usr/bin/build.sh

RUN mkdir /build

VOLUME [ "/build" ]
