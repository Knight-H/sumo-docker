FROM ubuntu:18.04

MAINTAINER Knight H. (thanapapas@hotmail.com)

ENV SUMO_VERSION 1.0.1
ENV SUMO_HOME /opt/sumo

# Install required dependencies
RUN apt-get update && apt-get -y install \
    wget g++ make \
    libxerces-c-dev libfox-1.6-dev libproj-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Download sumo and extract source code
RUN wget http://downloads.sourceforge.net/project/sumo/sumo/version%20$SUMO_VERSION/sumo-src-$SUMO_VERSION.tar.gz && \
    tar xf sumo-src-$SUMO_VERSION.tar.gz && \
    mv sumo-$SUMO_VERSION $SUMO_HOME && \
    rm sumo-src-$SUMO_VERSION.tar.gz

# Configure and build from source.
RUN cd $SUMO_HOME && ./configure && make install

WORKDIR "/workdir"

# (Optional) remove the SUMO_HOME for light image
RUN rm -rf $SUMO_HOME && apt-get autoremove
