FROM debian:jessie
MAINTAINER Lorenz Vanthillo <lorenz.vanthillo@outlook.com>
RUN apt-get -y update \
  && apt-get install -y python python-dev python-pip python-virtualenv \
  && rm -rf /var/lib/apt/lists/*
RUN pip install awscli
ADD run.sh /run.sh
CMD ["./run.sh"]
