FROM node:lts-alpine
LABEL maintainer="lizheming <i@imnerd.org>"
RUN apk upgrade --no-cache && apk add --no-cache bash

ENV ROOT /usr/src/app
WORKDIR ${ROOT}

RUN npm install coveralls

ADD ./entrypoint.sh .
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]