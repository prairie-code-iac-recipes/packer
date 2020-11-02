FROM golang:1.14-buster
LABEL maintainer="The Salte Team <admin@salte.io>"

ENV PACKER_DEV=1

RUN go get github.com/mitchellh/gox
RUN go get github.com/davewoodward/packer

WORKDIR $GOPATH/src/github.com/hashicorp/packer

RUN /bin/bash scripts/build.sh

WORKDIR $GOPATH
ENTRYPOINT ["bin/packer"]