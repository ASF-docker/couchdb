FROM debian:jessie
MAINTAINER Ryuichi Tokugami <magcot.com@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

ADD . /home/couchdb
WORKDIR /home/couchdb


# Configure backports
# Install prereqs
RUN apt-get update;  apt-get --no-install-recommends -y install \
  build-essential pkg-config ca-certificates \
  libcurl4-openssl-dev libssl-dev curl \
  erlang  erlang-dev erlang-nox \
  libmozjs185-dev python git \
  libicu-dev icu-devtools gnupg; \
  sed -i'' '/require_otp_vsn/d' rebar.config.script;  \
  ./configure --disable-docs ; \
  make -f Makefile.linux clean release ; \
  sed -i'' 's/bind_address = 127.0.0.1/bind_address = 0.0.0.0/' rel/couchdb/etc/default.ini;  \
  cp -r rel/couchdb /usr/local/lib; \
  ln -s /usr/local/lib/couchdb/etc/ /usr/local/etc/couchdb; \
  ln -s /usr/local/lib/couchdb/bin/* /usr/local/bin/; \
  ln  -s /usr/local/lib/couchdb/data /srv/couchdb ; \
   apt-get clean ; rm -rf /home/couchdb ;


EXPOSE 5984 5986
ENTRYPOINT ["/usr/local/lib/couchdb/bin/couchdb"]
