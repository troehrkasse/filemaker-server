FROM ubuntu:20.04

# Add any needed files
ADD filemaker-server-19.5.4.400-amd64.deb /fm-installer/filemaker-server-19.5.4.400-amd64.deb
ADD LicenseCert-2.fmcert /fm-installer/LicenseCert-2.fmcert
ADD ["Assisted Install.txt", "/fm-installer/Assisted Install.txt"]

# Install various utilities 
RUN apt-get update

RUN apt-get install                  -y \
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
        libavahi-client3                \
        libbz2-1.0                      \
        libcurl4                        \
        libdjvulibre21                  \
        libevent-2.1-6                  \
        libexpat1                       \
        libfontconfig1                  \
        libfreetype6                    \
        libgomp1                        \
        libicu60                        \
        libilmbase12                    \
        libjpeg-turbo8                  \
        liblqr-1-0                      \
        liblzma5                        \
        libodbc1                        \
        libopenexr22                    \
        libpng16-16                     \
        libsasl2-2                      \
        libtiff5                        \
        libuuid1                        \
        libvpx5                         \
        libwebpdemux2                   \
        libwebpmux3                     \
        libxml2                         \
        libxpm4                         \
        libxslt1.1                      \
        odbcinst1debian2                \
        openjdk-11-jre                  \
        openssl                         \
        policycoreutils                 \
        sysstat                         \
        unzip                           \
        zip                             \
        zlib1g

RUN apt-get update
RUN apt-get -y upgrade

# Install FileMaker Server 19
RUN FM_ASSISTED_INSTALL=/fm-installer apt install /fm-installer/filemaker-server-19.5.4.400-amd64.deb

# Required ports
EXPOSE 80
EXPOSE 443
EXPOSE 2399
EXPOSE 5003

# Run as root
USER root
CMD ["/sbin/init"]