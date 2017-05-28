FROM grpc/go
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
  wget https://codeload.github.com/google/protobuf/tar.gz/v3.3.0 && \
  tar xvzf v3.3.0 && \
  rm v3.3.0 && \
  cd protobuf-3.3.0 && \
  ./autogen.sh && \
  ./configure --prefix=/usr && \
  make && \
  make check && \
  make install && \
  cd - && \
  rm -rf protobuf-3.3.0

RUN git clone https://github.com/grpc/grpc && \
    cd grpc && \
    git submodule update --init

RUN cd grpc && make -j4 && make install
