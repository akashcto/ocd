FROM akash/baseimage
MAINTAINER CTO OCD <cto-ocd@wipro.com>

ENV HOME /root
RUN mkdir /build
ADD . /build
RUN /build/initialconfig.sh
RUN /build/initialrequire.sh
RUN /build/install.sh

