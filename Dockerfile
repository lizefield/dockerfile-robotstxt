# /_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
FROM python:3.9.13-slim-buster AS base

ENV LANG C.UTF-8

RUN set -x \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
    curl gnupg git \
  && apt-get install -y build-essential cmake \
  && :

RUN set -x \
  && git clone https://github.com/google/robotstxt.git /usr/local/src/robotstxt \
  && sed -i -e 21s/master/main/ /usr/local/src/robotstxt/CMakeLists.txt.in \
  && mkdir /usr/local/src/robotstxt/c-build \
  && cd /usr/local/src/robotstxt/c-build \
  && cmake .. -DROBOTS_BUILD_TESTS=ON \
  && make \
  && make test \
  && :

# /_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
FROM python:3.9.13-slim-buster

SHELL ["/bin/bash", "-c"]

ENV LANG C.UTF-8

COPY --from=base /usr/local/src/robotstxt/c-build/robots /usr/local/bin/robots
COPY --from=base /usr/local/src/robotstxt/c-build/librobots.so /usr/local/lib/librobots.so

RUN set -x \
  && echo /usr/local/lib > /etc/ld.so.conf.d/usr-local-lib.conf \
  && ldconfig -v \
  && :

WORKDIR /usr/local/src
