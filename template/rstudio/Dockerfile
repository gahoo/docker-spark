FROM rocker/rstudio:3.5.2

# install Spark
ENV SPARK_VERSION=2.4.3
ENV HADOOP_VERSION=2.7

RUN wget http://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark \
    && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

# install arrow C++ library
RUN sed -E 's#(security|deb).debian.org#mirrors.tuna.tsinghua.edu.cn#g' /etc/apt/sources.list -i
RUN apt update && \
    apt install -y -V apt-transport-https curl gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl --output /usr/share/keyrings/apache-arrow-keyring.gpg https://dl.bintray.com/apache/arrow/debian/apache-arrow-keyring.gpg && \
    curl https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

ADD sources.list.d /etc/apt/sources.list.d

RUN apt update && \
    apt install -y -V libarrow-dev libarrow-glib-dev libparquet-dev libparquet-glib-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install other stuff
RUN apt-get update -y -q && \
    apt-get install -y -q --no-install-recommends --allow-unauthenticated \
    openssh-client libxml2-dev tcl8.6-dev tk8.6-dev libhdf5-dev build-essential cmake gsl-bin libgsl0-dev libeigen3-dev libboost-all-dev libssl-dev libcurl4-openssl-dev libxt-dev libgtk2.0-dev libcairo2-dev xvfb xauth xfonts-base python-pip openjdk-8-jre && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install arrow and sparklyr
ADD installRpkg.R /tmp/installRpkg.R
RUN Rscript /tmp/installRpkg.R && \
    rm /tmp/installRpkg.R

# install umap-learn
RUN apt-get remove -y python-pip && \
    curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py && \
    python /tmp/get-pip.py && \
    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple umap-learn

