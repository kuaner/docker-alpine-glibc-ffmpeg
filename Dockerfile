FROM alpine:3.11

LABEL maintainer="kuaner@gmail.com"

ENV GLIBC_VERSION=2.31-r0
ENV VER=4.2.2

# Download and install glibc ffmpeg
RUN apk add --update curl tzdata busybox-extras && \
  curl -Lo /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
  curl -Lo glibc.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
  curl -Lo glibc-bin.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" && \
  curl -Lo glibc-i18n.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-i18n-${GLIBC_VERSION}.apk" && \
  apk add glibc.apk glibc-bin.apk glibc-i18n.apk && \
  /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 && \
  /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
  echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
  curl -Lo ffmpeg-release-amd64-static.tar.xz https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz && \
  tar xvJf ffmpeg-release-amd64-static.tar.xz && \
  cp ./ffmpeg-${VER}-amd64-static/ffmpeg /usr/bin/ && \
  cp ./ffmpeg-${VER}-amd64-static/ffprobe /usr/bin/ && \
  rm -rf glibc.apk glibc-bin.apk glibc-i18n.apk /var/cache/apk/* ffmpeg-${VER}-amd64-static ffmpeg-release-amd64-static.tar.xz

ENV TZ=Asia/Shanghai
