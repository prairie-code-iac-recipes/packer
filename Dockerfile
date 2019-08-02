FROM golang:1.12.7-stretch
LABEL maintainer="The Salte Team <admin@salte.io>"

ENV PACKER_DEV=1

RUN go get github.com/mitchellh/gox
RUN go get github.com/hashicorp/packer

WORKDIR $GOPATH/src/github.com/hashicorp/packer

RUN /bin/bash scripts/build.sh

RUN wget -q https://s3.amazonaws.com/io.salte.vmware/VMware-ovftool-4.3.0-12320924-lin.x86_64.bundle \
 && sh VMware-ovftool-4.3.0-12320924-lin.x86_64.bundle -p /usr/local --eulas-agreed --required \
 && rm -f VMware-ovftool-4.3.0-12320924-lin.x86_64.bundle

WORKDIR $GOPATH
ENTRYPOINT ["bin/packer"]