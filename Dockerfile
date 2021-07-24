# GCC support can be specified at major, minor, or micro version
# (e.g. 8, 8.2 or 8.2.0).
# See https://hub.docker.com/r/library/gcc/ for all supported GCC
# tags from Docker Hub.
# See https://docs.docker.com/samples/library/gcc/ for more on how to use this image

# Get the base Ubuntu image from Docker Hub
FROM ubuntu:latest

# Update apps on the base image
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q tzdata
#ENV TZ=Asia/Kolkata
#RUN DEBIAN_FRONTEND=noninteractive apt-get install tzdata
RUN apt-get -y update  
RUN apt-get install apt-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y keyboard-configuration
RUN apt-get -y upgrade


# Install the Clang compiler
RUN apt-get -y install gcc g++ \
 libwxbase3.0-0v5 \
 libwxbase3.0-dev\
 libwxgtk3.0-gtk3-0\
 libwxgtk3.0-gtk3-dev\
 wx3.0-headers\
 wx3.0-i18n\
 libfontconfig1-dev \
  build-essential\
  autotools-dev\
  automake

# Copy the current folder which contains C++ source code to the Docker image under /usr/src
COPY . /usr/src/maitreya8

# Specify the working directory
WORKDIR /usr/src/maitreya8

# Run the program output from the previous step
RUN  /usr/src/maitreya8/configure

RUN make && make install
RUN maitreya8
LABEL Name=maitreya8 Version=8.0.1
