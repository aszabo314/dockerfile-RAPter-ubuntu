# Pull base image
FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive

# some prereqs
RUN apt-get update -y
RUN apt-get install -y python3-pip python3-dev
RUN apt-get install -y liblapack-dev
RUN apt-get install -y libblas-dev
RUN apt-get install -y gfortran
RUN apt-get install -y subversion
RUN apt-get install -y wget
RUN apt-get install -y git

# install CoinBonmin
RUN mkdir ~/workspace
RUN mkdir ~/workspace/3rdparty
RUN cd ~/workspace/3rdparty && svn co https://projects.coin-or.org/svn/Bonmin/stable/1.5 CoinBonmin-stable
RUN cd ~/workspace/3rdparty && CoinBonmin-stable/ThirdParty/Mumps/get.Mumps
RUN cd ~/workspace/3rdparty/CoinBonmin-stable && mkdir build && cd build && ../configure -C && make && make install

# more prereqs
RUN apt-get install -y libopencv-calib3d-dev  
RUN apt-get install -y libopencv-contrib-dev 
RUN apt-get install -y libopencv-features2d-dev
RUN apt-get install -y libopencv-highgui-dev
RUN apt-get install -y libopencv-imgcodecs-dev
RUN apt-get install -y libopencv-objdetect-dev
RUN apt-get install -y libopencv-shape-dev
RUN apt-get install -y libopencv-stitching-dev
RUN apt-get install -y libopencv-superres-dev
RUN apt-get install -y libopencv-video-dev
RUN apt-get install -y libopencv-videoio-dev
RUN apt-get install -y libopencv-videostab-dev
RUN apt-get install -y libopencv4.2-java
RUN apt-get install -y libopencv-calib3d4.2
RUN apt-get install -y libopencv-contrib4.2
RUN apt-get install -y libopencv-features2d4.2
RUN apt-get install -y libopencv-highgui4.2
RUN apt-get install -y libopencv-imgcodecs4.2
RUN apt-get install -y libopencv-videoio4.2
RUN apt-get install -y libgdal26
RUN apt-get install -y libodbc1
RUN apt-get install -y libopencv-dev
RUN apt-get install -y libpcl-dev
RUN apt-get install -y cmake

# build libfbi
RUN cd ~/workspace/3rdparty && git clone https://github.com/mkirchner/libfbi.git
RUN cd ~/workspace/3rdparty/libfbi && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make

# build rapter
RUN cd ~/workspace/3rdparty && git clone https://github.com/amonszpart/RAPter.git
# RUN cd ~/workspace/RAPter && mkdir build && cd build && ../configure -C && make && make install