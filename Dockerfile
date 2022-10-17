FROM ubuntu:20.04

# Add any needed files
ADD filemaker-server-19.5.4.400-amd64.deb /fm-installer/filemaker-server-19.5.4.400-amd64.deb
ADD LicenseCert-2.fmcert /fm-installer/LicenseCert-2.fmcert
ADD ["Assisted Install.txt", "/fm-installer/Assisted Install.txt"]

# Set environment variables
ENV FM_ASSISTED_INSTALL="/fm-installer"
ENV DEBIAN_FRONTEND="noninteractive"
ENV TZ="Etc/UTC"

# Install various utilities 
RUN apt-get update

RUN apt-get install                  -y \
        curl                         -y \
        unzip                        -y \
        zip

RUN apt-get update
RUN apt-get -y upgrade

# Install FileMaker Server 19
RUN apt-get install -y /fm-installer/filemaker-server-19.5.4.400-amd64.deb

# Required ports
EXPOSE 80
EXPOSE 443
EXPOSE 2399
EXPOSE 5003

# Run as root
USER root
CMD ["/sbin/init"]
