FROM geoffreybooth/meteor-base:1.8

RUN apt-get update && apt-get -y install jq

COPY . /source

RUN cd /source \
 && mv docker-entrypoint.sh /usr/local/bin/ \
 && mkdir /app 

RUN cd /source \
 && meteor npm install \
 && meteor build --directory /app

ENV NODE_ENV production

RUN cd /app/bundle/programs/server \
 && meteor npm install \
 && meteor npm cache clear --force

WORKDIR /app/bundle

ENV MONGO_URL=mongodb://mongo:27017/html5client \
    PORT=3000 \
    ROOT_URL=http://localhost:3000 \
    METEOR_SETTINGS_MODIFIER=.

EXPOSE 3000

CMD ["docker-entrypoint.sh"]
