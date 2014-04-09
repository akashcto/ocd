FROM ubuntu
RUN apt-get install -y wget build-essential
RUN apt-get install -y curl
RUN wget http://download.zeromq.org/zeromq-3.2.3.tar.gz
RUN tar xzf zeromq-3.2.3.tar.gz
WORKDIR /zeromq-3.2.3
RUN ./configure
RUN make
RUN make install
RUN ldconfig

WORKDIR /
RUN ldconfig

RUN curl http://nodejs.org/dist/v0.10.22/node-v0.10.22-linux-x64.tar.gz | tar xz --strip-components=1
RUN echo "export PATH=$PATH:/node/bin" >> ~/.bashrc
RUN . ~/.bashrc

RUN npm install node-gyp rebuild
RUN npm install zmq
RUN ldconfig

RUN echo tlsv1 > $HOME/.curlrc
RUN curl https://install.meteor.com/ | sh
