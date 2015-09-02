# Image based on Ubuntu 14.04 with CUDA installed
#
# Copyright (c) 2015- Quanticare Technologies

# Base Image
FROM ubuntu:14.04.2

MAINTAINER Savant Krishna <savant@quanti.care>

#RUN sed -i "s/archive\.ubuntu/mirrors.digitalocean/g" /etc/apt/sources.list

#ENV CUDA_DEB http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_7.0-28_amd64.deb
ENV CUDA_DEB 'http://developer.download.nvidia.com/compute/cuda/7_0/Prod/local_installers/rpmdeb/cuda-repo-ubuntu1404-7-0-local_7.0-28_amd64.deb
##http://developer.download.nvidia.com/compute/cuda/7_0/Prod/local_installers/cuda_7.0.28_linux.run


RUN apt-get update && apt-get install -q -y \
  axel wget build-essential 

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /tmp-cuda && cd /tmp-cuda && \
  #axel -n16 $CUDA_RUN && \
  axel -n16 -q $CUDA_DEB && \
  #chmod +x *.run && \
  #mkdir nvidia_installers && \
  #./cuda_7.0.28_linux.run -extract=`pwd`/nvidia_installers && \
  #cd nvidia_installers && \
  #./NVIDIA-Linux-x86_64-346.46.run -s -N --no-kernel-module && \
  #./cuda-linux64-rel-7.0.28-19326674.run -noprompt && \
  #./cuda-samples-linux-7.0.28-19326674.run -cudaprefix=/usr/local/cuda-7.0/ -noprompt &&  \
  #cd .. && \ 

#RUN dpkg -i /tmp-cuda/*.deb && \
  dpkg -i /tmp-cuda/*.deb && \
  apt-get update && \
  apt-get install -q -y --force-yes cuda && \
  apt-get purge -y cuda-repo-ubuntu1404-7-0-local && rm -rf /var/lib/apt/lists/* && \
  rm /tmp-cuda/*.deb

# Ensure the CUDA libs and binaries are in the correct environment variables
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-7.0/lib64
ENV PATH=$PATH:/usr/local/cuda-7.0/bin:/usr/lib/nvidia-346/bin
