FROM      ubuntu
MAINTAINER Ajay

RUN apt-get update

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

RUN apt-get install -y  curl
RUN apt-get install -y python2.7
RUN apt-get install -y python-setuptools python-virtualenv python-dev
RUN apt-get install -y python-zmq
RUN apt-get install -y python-httplib2
RUN apt-get install -y python-pip

RUN wget https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.6.tar.gz#md5=1c49a8825c993bfdcf55bb36897d28a2
RUN tar xvzf Jinja2-2.6.tar.gz
WORKDIR Jinja2-2.6
RUN python setup.py install

WORKDIR /

RUN wget https://pypi.python.org/packages/source/W/Werkzeug/Werkzeug-0.8.3.tar.gz#md5=12aa03e302ce49da98703938f257347a
RUN tar xvzf Werkzeug-0.8.3.tar.gz
WORKDIR Werkzeug-0.8.3
RUN python setup.py install

WORKDIR /

RUN wget https://pypi.python.org/packages/source/F/Flask/Flask-0.8.1.tar.gz#md5=4b9e866bf43723d834b3ce8fcd13574d
RUN tar xvzf Flask-0.8.1.tar.gz
WORKDIR Flask-0.8.1
RUN python setup.py install

WORKDIR /