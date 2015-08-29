FROM ubuntu:14.04

ENV BOOTCAMP_USER ejabberd
ENV BOOTCAMP_HOME /opt/bootcamp
ENV HOME $BOOTCAMP_HOME
ENV PATH $BOOTCAMP_HOME/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV DEBIAN_FRONTEND noninteractive

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN groupadd -r $BOOTCAMP_USER \
    && useradd -r -m \
       -g $BOOTCAMP_USER \
       -d $BOOTCAMP_HOME \
       $BOOTCAMP_USER

RUN apt-get update -qq
RUN apt-get upgrade -y -qq

RUN apt-get install -y -qq python2.7
RUN apt-get install -y -qq git python python-pip
## needed for pip install
RUN apt-get install -y -qq libpq-dev python-dev python-imaging


RUN git clone git://github.com/django/django.git django-trunk
RUN pip install -e django-trunk/

RUN git clone https://github.com/vitorfs/bootcamp.git

WORKDIR bootcamp

RUN pip install -U -r requirements.txt

ADD ./run.sh /sbin/run

# Continue as user
USER $BOOTCAMP_USER

# VOLUME ["$BOOTCAMP_HOME"]
EXPOSE 80 443

CMD ["/sbin/run"]
