FROM localhost:5000/bde/spark-base-arrow:r-3.5

MAINTAINER Artem Klevtsov a.a.klevtsov@gmail.com

ADD installRpkg.R /tmp/installRpkg.R
RUN apk add libxml2 libxml2-dev && \
    Rscript /tmp/installRpkg.R
