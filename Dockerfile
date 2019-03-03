FROM resin/rpi-raspbian

MAINTAINER Louis <pm6422@126.com>                                                                                                                        
                                                                                                                                                         
# Install the build dependencies.                                                                                                                        
RUN apt-get update && apt-get install -y \                                                                                                               
        git \                                                                                                                                            
        build-essential \                                                                                                                                
        autoconf \                                                                                                                                       
        automake \                                                                                                                                       
        libtool \                                                                                                                                        
        libltdl-dev \                                                                                                                                    
        libao-dev \                                                                                                                                      
        libavahi-compat-libdnssd-dev \                                                                                                                   
        avahi-daemon \                                                                                                                                   
        libdaemon-dev \                                                                                                                                  
        libasound2-dev \                                                                                                                                 
        libpopt-dev \                                                                                                                                    
        libconfig-dev \                                                                                                                                  
        libavahi-client-dev \                                                                                                                            
        libssl-dev                                                                                                                                       
                                                                                                                                                         
# Clone and build the package.                                                                                                                           
RUN git clone https://github.com/juhovh/shairplay.git                                                                                                    
                                                                                                                                                         
WORKDIR shairplay                                                                                                                                        
RUN ./autogen.sh                                                                                                                                         
RUN ./configure --with-alsa --with-avahi --with-ssl=openssl --with-systemd --sysconfdir=/etc                                                             
                                                                                                                                                         
RUN make                                                                                                                                                 
RUN sudo make install                                                                                                                                    
                                                                                                                                                         
# Put the AirPort encryption key in the home directory.                                                                                                  
# RUN cp shairplay/airport.key airport.key                                                                                                               
                                                                                                                                                         
# TODO Remove the build dependencies. Delete the source.                                                                                                 
                                                                                                                                                         
# The AirPlay ports.                                                                                                                                     
#EXPOSE 3689/tcp                                                                                                                                         
#EXPOSE 5000-5005/tcp                                                                                                                                    
#EXPOSE 6000-6005/udp                                                                                                                                    
                                                                                                                                                         
#CMD ["shairplay", "-a 'Airplay Speaker'"]                                                                                                               
                                                                                                                                                         
RUN sed -i 's/rlimit-nproc=3//' /etc/avahi/avahi-daemon.conf                                                                                             
                                                                                                                                                         
COPY start.sh /start.sh                                                                                                                                  
RUN chmod +x /start.sh                                                                                                                                   
CMD /start.sh
