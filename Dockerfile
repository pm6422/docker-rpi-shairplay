FROM resin/rpi-raspbian
MAINTAINER Louis <pm6422@126.com>

# Install the build dependencies.
RUN apt-get update && \
        apt-get install -y \
        git \
        apt-get install autoconf automake libtool \
        apt-get install libltdl-dev libao-dev libavahi-compat-libdnssd-dev \
        apt-get install avahi-daemon

# Clone and build the package.
RUN git clone https://github.com/juhovh/shairplay.git
RUN cd shairplay && \
    ./autogen.sh && \
    ./configure && \
    make && \
    sudo make install

# Put the AirPort encryption key in the home directory.
# RUN cp shairplay/airport.key airport.key

# TODO Remove the build dependencies. Delete the source.

# The AirPlay ports.
EXPOSE 3689/tcp
EXPOSE 5000-5005/tcp
EXPOSE 6000-6005/udp

CMD ["shairplay", "-a 'Airplay Speaker'"]
