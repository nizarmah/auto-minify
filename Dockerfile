FROM node:13.10

WORKDIR /app/

COPY package.json /app/package.json

RUN npm install

RUN npm list

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]