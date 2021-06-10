#!/bin/bash

#### Colors ####
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
Light_BLUE='\033[1;34m'
Light_Cyan='\033[1;35m'
BLUE='\033[1;36m'
NC='\033[0m' # No Color
##################

set -e

# change default constants here:
readonly PREFIX=/usr/local  # install prefix, (can be ~/.local for a user install)
readonly DEFAULT_VERSION=4.2.0  # controls the default version (gets reset by the first argument)
readonly CPUS=$(nproc)  # controls the number of jobs

if [[ $CPUS -gt 1 ]]; then
    JOBS=$CPUS
else
    JOBS=1  
fi

cleanup () {
# https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script
    while true ; do
        echo "Do you wish to remove temporary build files in /tmp/build_opencv ? "
        if ! [[ "$1" -eq "--test-warning" ]] ; then
            echo "(Doing so may make running tests on the build later impossible)"
        fi
        read -p "Y/N " yn
        case ${yn} in
            [Yy]* ) rm -rf /tmp/build_opencv ; break;;
            [Nn]* ) exit ;;
            * ) echo "Please answer yes or no." ;;
        esac
    done
}

setup () {
    cd /tmp
    if [[ -d "build_opencv" ]] ; then
        echo "It appears an existing build exists in /tmp/build_opencv"
        cleanup
    fi
    mkdir build_opencv
    cd build_opencv
}

git_source () {
    echo "${Light_Cyan}Getting version '$1' of OpenCV${NC}"
    git clone --depth 1 --branch "$1" https://github.com/opencv/opencv.git
    git clone --depth 1 --branch "$1" https://github.com/opencv/opencv_contrib.git
}

install_dependencies () {
    echo "${Light_Cyan}Installing build dependencies.${NC}"
    sudo apt update
    sudo apt -y upgrade
    sudo apt -y install \
        build-essential \
        cmake \
        pkg-config \
        libjpeg-dev \
        libtiff5-dev \
        libjasper-dev \
        libpng-dev \
        libavcodec-dev 
        libavformat-dev 
        libswscale-dev
        libdc1394-22-dev 
        libxvidcore-dev 
        libx264-dev x264
        libxine2-dev 
        libv4l-dev v4l-utils
        libgstreamer1.0-dev 
        libgstreamer-plugins-base1.0-dev
        libgtk-3-dev
        libatlas-base-dev 
        libeigen3-dev 
        gfortran
        mesa-utils 
        libgl1-mesa-dri 
        libqt4-opengl-dev
        python-numpy 
        python3-dev 
        python3-numpy 
        libtbb2 
        libtbb-dev
}

configure () {
    local CMAKEFLAGS="
        -D CMAKE_BUILD_TYPE=RELEASE 
        -D CMAKE_INSTALL_PREFIX=${PREFIX}
        -D WITH_TBB=OFF 
        -D WITH_IPP=OFF 
        -D WITH_1394=OFF 
        -D BUILD_WITH_DEBUG_INFO=OFF 
        -D BUILD_DOCS=OFF 
        -D INSTALL_C_EXAMPLES=ON 
        -D INSTALL_PYTHON_EXAMPLES=ON 
        -D BUILD_EXAMPLES=OFF 
        -D BUILD_TESTS=OFF 
        -D BUILD_PERF_TESTS=OFF 
        -D WITH_QT=OFF 
        -D WITH_GTK=ON 
        -D WITH_OPENGL=ON 
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules 
        -D WITH_V4L=ON  
        -D WITH_FFMPEG=ON 
        -D WITH_XINE=ON 
        -D BUILD_NEW_PYTHON_SUPPORT=ON 
        -D OPENCV_GENERATE_PKGCONFIG=ON ../"

    echo "cmake flags: ${CMAKEFLAGS}"

    cd opencv
    mkdir build
    cd build

    #https://skorks.com/2009/09/using-bash-to-output-to-screen-and-file-at-the-same-time/
    cmake ${CMAKEFLAGS} .. 2>&1 | tee -a configure.log
}

main () {
    local VER=${DEFAULT_VERSION}
    echo -e "${Light_Cyan}-- Install Opencv ${VER} Version --${NC}"
    # parse arguments
    if [[ "$#" -gt 0 ]] ; then
        VER="$1"  # override the version
    fi

    # prepare for the build:
    setup
    install_dependencies
    git_source ${VER}
    configure

    # start the build
    make -j${JOBS} 2>&1 | tee -a build.log

    # avoid a sudo make install (and root owned files in ~) if $PREFIX is writable
    # https://hand-over.tistory.com/32
    if [[ -w ${PREFIX} ]] ; then
        make install 2>&1 | tee -a install.log
    else
        sudo make install 2>&1 | tee -a install.log
    fi
    echo -e "${Light_BLUE}Finished Opencv ${VER} install${NC}"

    cleanup --test-warning
}

main "$@"