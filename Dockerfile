FROM ubuntu:14.04
MAINTAINER Yuri Freire <yurifrl@hotmail.com>
# Based on Dockerfile by Chris Laskey <contact@chirslaskey.com>

ENV PHOENIX_VERSION "0.14.0"

RUN locale-gen en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get -y install wget curl git make
RUN echo "deb http://packages.erlang-solutions.com/ubuntu precise contrib" >> /etc/apt/sources.list

RUN mkdir /downloads
WORKDIR /downloads

# Erlang
RUN wget http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc
RUN apt-key add erlang_solutions.asc
RUN apt-get update && apt-get -y install erlang

# Elixir
RUN mkdir /vendor
WORKDIR /vendor
RUN git clone https://github.com/elixir-lang/elixir.git

WORKDIR elixir
RUN git checkout v1.0.5 && make clean test
ENV PATH $PATH:/vendor/elixir/bin

# NodeJS
RUN apt-get install -y node npm

# App
RUN mkdir /app
WORKDIR /app
# ADD ./init.sh ./
# RUN ./init.sh

WORKDIR /app

# CMD ["../server.sh"]
