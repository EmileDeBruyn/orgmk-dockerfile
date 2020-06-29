## -*- docker-image-name: "orgmk-docker" -*-
FROM ubuntu:latest

USER root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
  emacs-nox \
  texlive-full \
	latexmk \
	git \
	make

# Cleanup
RUN  rm -rf /tmp/* /var/lib/apt/lists/* /root/.cache/*

RUN groupadd -r orgmk && useradd --no-log-init -r -m -g orgmk orgmk

WORKDIR /home/orgmk

RUN mkdir .emacs.d

# Install my version of OrgMK, forked from original by Fabrice Niessen (fniessen)
RUN git clone https://github.com/emiledebruyn/orgmk.git \
	&& cd orgmk \
  && make \
  && make install
