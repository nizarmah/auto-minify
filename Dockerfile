FROM node:current-alpine

WORKDIR /app/

COPY package.json /app/package.json

RUN apk add --no-cache bash coreutils \
 && apk add --no-cache --upgrade grep \
 && npm install

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
