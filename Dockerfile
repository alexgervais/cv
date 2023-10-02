FROM debian:11

ENV DEBIAN_FRONTEND noninteractive

# Install all TeX and LaTeX dependences
RUN apt-get update && \
  apt-get install --yes --no-install-recommends \
  ca-certificates \
  git \
  inotify-tools \
  lmodern \
  make \
  texlive-fonts-recommended \
  texlive-fonts-extra \
  texlive-lang-english \
  texlive-lang-french \
  texlive-plain-generic \
  texlive-xetex

RUN apt-get autoclean && apt-get --purge --yes autoremove && \
  rm -rf /tmp/* /var/tmp/*

COPY fonts /usr/share/fonts

# Export the output data
WORKDIR /data
VOLUME ["/data"]