FROM amd64/ubuntu:20.04

# Add any needed files
ADD filemaker-server-19.5.4.400-amd64.deb /fm-installer/filemaker-server-19.5.4.400-amd64.deb
ADD LicenseCert-2.fmcert /fm-installer/LicenseCert-2.fmcert
ADD ["Assisted Install.txt", "/fm-installer/Assisted Install.txt"]

# Set environment variables
ENV FM_ASSISTED_INSTALL="/fm-installer"
ENV DEBIAN_FRONTEND="noninteractive"
ENV TZ="Etc/UTC"

# Install various utilities 
RUN apt update

RUN apt full-upgrade -y

# FM Dependencies
RUN apt install                      -y \
        acl                             \
        apache2-bin                     \
        apache2-utils                   \
        avahi-daemon                    \
        curl                            \
        firewalld                       \
        fonts-baekmuk                   \
        fonts-liberation2               \
        fonts-noto                      \
        fonts-takao                     \
        fonts-wqy-zenhei                \
        libaio1                         \
        libantlr3c-3.4-0                \
        libavahi-client3                \
        libboost-chrono1.71.0           \
        libboost-system1.71.0           \
        libboost-thread1.71.0           \
        libbz2-1.0                      \
        libc++1-12                      \
        libcurl3-gnutls                 \
        libcurl4-gnutls-dev             \
        libcurl4                        \
        libdjvulibre21                  \
        libetpan20                      \
        libevent-2.1-7                  \
        libexpat1                       \
        libfontconfig1                  \
        libfreetype6                    \
        libgomp1                        \
        libheif1                        \
        libicu66                        \
        libilmbase24                    \
        libjpeg-turbo8                  \
        liblqr-1-0                      \
        liblzma5                        \
        libodbc1                        \
        libomniorb4-2                   \
        libomp5-12                      \
        libopenexr24                    \
        libpam0g                        \
        libpng16-16                     \
        libsasl2-2                      \
        libtiff5                        \
        libuuid1                        \
        libvpx6                         \
        libwebpdemux2                   \
        libwebpmux3                     \
        libxml2                         \
        libxpm4                         \
        libxslt1.1                      \
        lsb-release                     \
        logrotate                       \
        nginx                           \
        odbcinst1debian2                \
        openjdk-11-jre                  \
        openssl                         \
        policycoreutils                 \
        sysstat                         \
        unzip                           \
        zip                             \
        zlib1g

# install user management
RUN apt install                      -y \
        init

# clean up installations
RUN apt --fix-broken install         -y
RUN apt autoremove                   -y
RUN apt clean                        -y

# Required ports
EXPOSE 80
EXPOSE 443
EXPOSE 2399
EXPOSE 5003

# Run as root
USER root
CMD ["/sbin/init"]
