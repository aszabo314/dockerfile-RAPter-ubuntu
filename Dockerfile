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

# build opencv2
RUN apt-get install -y build-essential 
RUN apt-get install -y cmake 
RUN apt-get install -y libgtk2.0-dev 
RUN apt-get install -y pkg-config 
RUN apt-get install -y python-numpy 
RUN apt-get install -y python-dev 
RUN apt-get install -y libavcodec-dev 
RUN apt-get install -y libavformat-dev 
RUN apt-get install -y libswscale-dev 
RUN apt-get install -y libjpeg-dev 
RUN apt-get install -y libpng-dev 
RUN apt-get install -y libtiff5-dev 
RUN apt-get install -y software-properties-common 
RUN add-apt-repository -y "deb http://security.ubuntu.com/ubuntu xenial-security main"
RUN apt update -y 
RUN apt install -y libjasper1 libjasper-dev
RUN apt-get install -y libopencv-dev 
RUN apt-get install -y checkinstall 
RUN apt-get install -y pkg-config 
RUN apt-get install -y yasm 
RUN apt-get install -y libjpeg-dev 
RUN apt-get install -y libjasper-dev 
RUN apt-get install -y libavcodec-dev 
RUN apt-get install -y libavformat-dev 
RUN apt-get install -y libswscale-dev 
RUN apt-get install -y libdc1394-22-dev 
RUN apt-get install -y libxine2 
RUN apt-get install -y libgstreamer1.0-dev 
RUN apt-get install -y libv4l-dev 
RUN apt-get install -y libgstreamer-plugins-base1.0-dev 
RUN apt-get install -y python-dev 
RUN apt-get install -y python-numpy 
RUN apt-get install -y libtbb-dev 
RUN add-apt-repository -y ppa:rock-core/qt4
RUN apt update -y 
RUN apt install -y libqt4-dev 
RUN apt-get install -y libgtk2.0-dev 
RUN apt-get install -y libmp3lame-dev 
RUN apt-get install -y libopencore-amrnb-dev 
RUN apt-get install -y libopencore-amrwb-dev 
RUN apt-get install -y libtheora-dev 
RUN apt-get install -y libvorbis-dev 
RUN apt-get install -y libxvidcore-dev 
RUN apt-get install -y x264 
RUN apt-get install -y v4l-utils 
RUN apt-get install -y unzip

RUN mkdir ~/opencv2 && cd ~/opencv2 && wget https://github.com/opencv/opencv/archive/2.4.13.5.zip -O opencv-2.4.13.5.zip
RUN cd ~/opencv2 && unzip opencv-2.4.13.5.zip && cd opencv-2.4.13.5 && mkdir release && cd release && cmake -G "Unix Makefiles" -DCMAKE_CXX_COMPILER=/usr/bin/g++ CMAKE_C_COMPILER=/usr/bin/gcc -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DWITH_TBB=ON -DBUILD_NEW_PYTHON_SUPPORT=ON -DWITH_V4L=ON -DINSTALL_C_EXAMPLES=ON -DINSTALL_PYTHON_EXAMPLES=ON -DBUILD_EXAMPLES=ON -DWITH_QT=ON -DWITH_OPENGL=ON -DBUILD_FAT_JAVA_LIB=ON -DINSTALL_TO_MANGLED_PATHS=ON -DINSTALL_CREATE_DISTRIB=ON -DINSTALL_TESTS=ON -DENABLE_FAST_MATH=ON -DWITH_IMAGEIO=ON -DBUILD_SHARED_LIBS=OFF -DWITH_GSTREAMER=ON .. 
RUN printf '%s\n%s\n' "#define AVFMT_RAWPICTURE 0x0020" "$(cat ~/opencv2/opencv-2.4.13.5/modules/highgui/src/cap_ffmpeg_impl.hpp)" >~/opencv2/opencv-2.4.13.5/modules/highgui/src/cap_ffmpeg_impl.hpp && printf '%s\n%s\n' "#define CODEC_FLAG_GLOBAL_HEADER AV_CODEC_FLAG_GLOBAL_HEADER" "$(cat ~/opencv2/opencv-2.4.13.5/modules/highgui/src/cap_ffmpeg_impl.hpp)" >~/opencv2/opencv-2.4.13.5/modules/highgui/src/cap_ffmpeg_impl.hpp && printf '%s\n%s\n' "#define AV_CODEC_FLAG_GLOBAL_HEADER (1 << 22)" "$(cat ~/opencv2/opencv-2.4.13.5/modules/highgui/src/cap_ffmpeg_impl.hpp)" >~/opencv2/opencv-2.4.13.5/modules/highgui/src/cap_ffmpeg_impl.hpp
RUN cd ~/opencv2/opencv-2.4.13.5/release && make all -j$(nproc)
RUN cd ~/opencv2/opencv-2.4.13.5/release && make install

# build libfbi
RUN cd ~/workspace/3rdparty && git clone https://github.com/mkirchner/libfbi.git
RUN apt-get install -y libboost-all-dev
RUN cd ~/workspace/3rdparty/libfbi && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make

# build rapter
RUN cd ~/workspace && git clone https://github.com/amonszpart/RAPter.git

RUN apt-get install -y nano
RUN apt-get install -y libgdal26
RUN apt-get install -y libodbc1
RUN apt-get install -y libopencv-dev
RUN apt-get install -y libpcl-dev
RUN apt-get install -y cmake
RUN cd ~/workspace/RAPter/RAPter && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. 
RUN printf '%s\n%s\n' "set(CMAKE_CXX_STANDARD_REQUIRED ON)" "$(cat /root/workspace/RAPter/RAPter/CMakeLists.txt)" >/root/workspace/RAPter/RAPter/CMakeLists.txt && printf '%s\n%s\n' "set(CMAKE_CXX_STANDARD 14)" "$(cat /root/workspace/RAPter/RAPter/CMakeLists.txt)" >/root/workspace/RAPter/RAPter/CMakeLists.txt
RUN apt-get install -y libmumps-dev
RUN cd ~/workspace/3rdparty/CoinBonmin-stable/build/lib && wget https://forge.scilab.org/index.php/p/sci-ipopt/source/tree/87d40abff2e10dfa799dab2962e52179a2596cc1/thirdparty/Linux/lib/x64/libcoinmumps.so.1.4.7 && mv libcoinmumps.so.1.4.7 libcoinmumps.so
RUN cd ~/workspace/RAPter/RAPter/build && make