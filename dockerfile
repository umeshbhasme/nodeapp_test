FROM node:${NODE_VERSION:-14.19.2} AS deps

WORKDIR /usr/app

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i s/deb.debian.org/archive.debian.org/g /etc/apt/sources.list
RUN sed -i 's|security.debian.org|archive.debian.org/|g' /etc/apt/sources.list
RUN sed -i '/stretch-updates/d' /etc/apt/sources.list

RUN apt update && apt -y dist-upgrade

RUN apt update && apt install musl-dev -y && \
    ln -s /usr/lib/x86_64-linux-musl/libc.so /lib/libc.musl-x86_64.so.1

COPY . .
# RUN yarn install --frozen-lockfile

RUN npm install pm2 -g

RUN mkdir ~/.ssh && \
    ssh-keyscan -H github.com >> ~/.ssh/known_hosts

CMD ["./index.js"]
