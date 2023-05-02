#!/bin/bash

# ========Version========
image_name=${1:-dreamcmi/cv1800-docker:1.0}

# ========SDK========
echo -e "\e[0;32mDownload cvi_mmf_sdk\e[0m"

if [ -d "cvi_mmf_sdk" ];then
    echo "cvi_mmf_sdk already exists"
else
    git clone https://github.com/dreamcmi/cvi_mmf_sdk
fi

if [ $? -eq 0 ]; then
		echo "Success"
else
		echo "Failed!"
		exit 1
fi

# ========host-tools========
echo -e "\e[0;32mDownload host-tools\e[0m"

if [ -f "host-tools.tar.gz" ];then
    echo "host-tools.tar.gz already exists"
else
    wget https://sophon-file.sophon.cn/sophon-prod-s3/drive/23/03/07/16/host-tools.tar.gz
fi

if [ $? -eq 0 ]; then
		echo "Success"
else
		echo "Failed!"
		exit 1
fi

# ========cmake========
echo -e "\e[0;32mDownload CMake\e[0m"

if [ -f "cmake-3.26.3.tar.gz" ];then
    echo "cmake-3.26.3.tar.gz already exists"
else
    wget https://github.com/Kitware/CMake/releases/download/v3.26.3/cmake-3.26.3.tar.gz
fi

if [ $? -eq 0 ]; then
		echo "Success"
else
		echo "Failed!"
		exit 1
fi

# ========genimage========
echo -e "\e[0;32mDownload genimage\e[0m"

if [ -d "genimage" ];then
    echo "genimage already exists"
else
    git clone https://github.com/pengutronix/genimage
fi

if [ $? -eq 0 ]; then
		echo "Success"
else
		echo "Failed!"
		exit 1
fi

# ========toolchain========
echo -e "\e[0;32mPrepare toolchain\e[0m"

if [ -d "host-tools" ];then
    echo "host-tools already exists"
else
    tar xf host-tools.tar.gz
fi

cd cvi_mmf_sdk/

if [ -d "host-tools" ];then
    echo "cvi_mmf_sdk/host-tools already exists"
else
    ln -s ../host-tools ./
fi

cd ..

if [ $? -eq 0 ]; then
		echo "Success"
else
		echo "Failed!"
		exit 1
fi

# ========Docker Images========
echo -e "\e[0;32mBuild Docker Images\e[0m"

docker build -t ${image_name} .

if [ $? -eq 0 ]; then
		echo "Success"
else
		echo "Failed!"
		exit 1
fi
