FROM alpine:3.6

MAINTAINER ageekymonk <ramzthecoder@gmail.com>

ARG GOCD_VERSION=17.11.0
ARG GOCD_SRC_URL=https://github.com/gocd/gocd
ARG GOCD_GIT_SHA=9f6909e2f64b07d2dce5cecd4ea5b92b8e19d6b1
ARG GOCD_URL=https://download.gocd.org/binaries/17.11.0-5520/generic/go-server-17.11.0-5520.zip
ARG LANG=en_AU.utf8
ARG UID=1000
ARG GID=1000

LABEL gocd.version="${GOCD_VERSION}" \
  description="GoCD server based on alpine linux" \
  gocd.git.sha="${GOCD_GIT_SHA}"

# the ports that go server runs on
EXPOSE 8153 8154

# force encoding
ENV LANG=${LANG}

RUN \
  addgroup -g ${GID} go && \
  adduser -D -u ${UID} -G go go && \
  apk --no-cache upgrade && \
  apk add --no-cache openjdk8-jre-base git mercurial subversion tini openssh-client bash su-exec curl && \
  curl --fail --location --silent --show-error "${GOCD_URL}" > /tmp/go-server.zip && \
  unzip /tmp/go-server.zip -d / && \
  rm /tmp/go-server.zip && \
  mv go-server-${GOCD_VERSION} /go-server

COPY logback-include.xml /go-server/config/logback-include.xml

ADD docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
