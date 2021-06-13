FROM node:lts-alpine
LABEL maintainer="lizheming <i@imnerd.org>"
RUN apk upgrade --no-cache && apk add --no-cache bash

RUN npm install -g coveralls

ADD ./entrypoint.sh /bin
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
