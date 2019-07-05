# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

FROM localhost:5000/bde/spark-base:2.4.3-hadoop2.7

# Install basic build dependencies
# grpc requires libnsl-dev to be present, this cannot be installed via a bundle.
RUN apk update && \
        apk add --no-cache -q \
        autoconf \
        bash \
        bison \
        boost-dev \
        ccache \
        cmake \
        flex \
        g++ \
        gcc \
        git \
        gzip \
        make \
        libnsl-dev \
        musl-dev \
        ninja \
        libressl-dev \
        wget \
        zlib-dev

# Ganidva is deactivated as we don't support building LLVM via ExternalProject
# and Alpine only has LLVM 6 in its repositories yet.
# ARROW-4917: ORC fails with compiler problems
ENV CC=gcc \
    CXX=g++ \
    ARROW_GANDIVA=OFF \
    ARROW_ORC=OFF \
    ARROW_PARQUET=ON \
    ARROW_BUILD_TESTS=ON \
    ARROW_HOME=/usr/local

# build and test
# https://github.com/apache/arrow/blob/master/ci/docker_build_cpp.sh
ADD docker_build_cpp.sh docker_build_cpp.sh
RUN wget http://mirrors.tuna.tsinghua.edu.cn/apache/arrow/arrow-0.13.0/apache-arrow-0.13.0.tar.gz && \
    tar -xf apache-arrow-0.13.0.tar.gz && \
    sed -i -e 's#://#://10.128.20.16:8123/#g' \
        -e 's/https/http/g' \
        apache-arrow-0.13.0/cpp/thirdparty/versions.txt \
        apache-arrow-0.13.0/cpp/cmake_modules/ThirdpartyToolchain.cmake \
        apache-arrow-0.13.0/python/cmake_modules/ThirdpartyToolchain.cmake \
        apache-arrow-0.13.0/python/manylinux1/scripts/build*.sh && \
    cat apache-arrow-0.13.0/cpp/cmake_modules/ThirdpartyToolchain.cmake |grep http && \
    bash docker_build_cpp.sh /apache-arrow-0.13.0/cpp /apache-arrow-0.13.0/build && \
    rm -rf apache-arrow-0.13.0* docker_build_cpp.sh
