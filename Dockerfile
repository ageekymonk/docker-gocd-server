FROM alpine:3.6

MAINTAINER ageekymonk <ramzthecoder@gmail.com>

ARG GOCD_VERSION=17.10.0
ARG GOCD_SRC_URL=https://github.com/gocd/gocd
ARG GOCD_GIT_SHA=05598d88fd4dabdde1184faa4fbffc5f9406d0dc
ARG GOCD_URL=https://download.gocd.org/binaries/17.10.0-5380/generic/go-server-17.10.0-5380.zip
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
  mv go-server-${GOCD_VERSION} /go-server && \
  sed -i -e 's/\(log4j.rootLogger.*\)/\1, stdout/g' /go-server/config/log4j.properties && \
  echo "" >> /go-server/config/log4j.properties && \
  echo "" >> /go-server/config/log4j.properties && \
  echo "# Log to stdout" >> /go-server/config/log4j.properties && \
  echo "log4j.appender.stdout=org.apache.log4j.ConsoleAppender" >> /go-server/config/log4j.properties && \
  echo "log4j.appender.stdout.layout=org.apache.log4j.PatternLayout" >> /go-server/config/log4j.properties && \
  echo "log4j.appender.stdout.layout.conversionPattern=%d{ISO8601} %5p [%t] %c{1}:%L - %m%n" >> /go-server/config/log4j.properties

ADD docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
