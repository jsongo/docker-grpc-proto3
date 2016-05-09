# FROM golang:1.6
FROM docker.io/grpc/python:0.11-onbuild
MAINTAINER jsongo@qq.com

RUN \
  apt-get update -yq && \
  apt-get install -yq --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    git \
    libtool \
    unzip && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN \
  wget https://codeload.github.com/google/protobuf/tar.gz/v3.0.0-beta-2 && \
  tar xvzf v3.0.0-beta-2 && \
  rm v3.0.0-beta-2 && \
  cd protobuf-3.0.0-beta-2 && \
  ./autogen.sh && \
  ./configure --prefix=/usr && \
  make && \
  make check && \
  make install && \
  cd - && \
  rm -rf protobuf-3.0.0-beta-2

RUN git clone https://github.com/grpc/grpc && \
    cd grpc && \
    git submodule update --init
RUN pip install -r requirements.txt
#RUN GRPC_PYTHON_BUILD_WITH_CYTHON=1 pip install .

RUN make && make install
RUN cd .. && rm -rf grpc

