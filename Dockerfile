FROM ubuntu:16.10

# Maintainer: Todd Wickizer

ENV PHOTPIPEDIR /usr/local/pipsrc
ENV PIPEGITADDRESS https://github.com/mommermi/photometrypipeline.git
ENV PYTHONPATH $PYTHONPATH:$PHOTPIPEDIR
ENV PATH $PATH:$PHOTPIPEDIR

RUN apt-get update && apt-get install -y \
   build-essential \
   libssl-dev \
   libffi-dev \
   python-dev \
   git \
   python \
   sextractor \
   python-pip \
   wget \
   curl \
   libplplot-dev \
   libshp-dev \
   libcurl4-gnutls-dev \
   liblapack3 liblapack-dev liblapacke liblapacke-dev \
   libfftw3-3 libfftw3-dev libfftw3-single3 \
   libatlas-base-dev


#   Create the path   
RUN mkdir -p $PHOTPIPEDIR
RUN cd $PHOTPIPEDIR \
   && git clone "$PIPEGITADDRESS" .

RUN pip install --upgrade pip
RUN pip install numpy
RUN pip install scipy
RUN pip install astropy
RUN pip install matplotlib
RUN pip install callhorizons
RUN pip install Pillow
RUN pip install future
RUN pip install cryptography
RUN pip install astroquery

#   Now we install scamp

WORKDIR $PHOTPIPEDIR

RUN wget https://cdn.rawgit.com/towicode/towicode.github.io/8d4d8670/scamp-trunk.r345.tar.gz
RUN gzip -dc scamp-* | tar xvf -
RUN cd trunk.r345 && ./configure --enable-threads && make && make install

CMD echo "Success!"

