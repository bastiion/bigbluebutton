FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y curl

RUN  curl -sL https://deb.nodesource.com/setup_8.x | bash - \
     && apt-get update \
     && apt-get install -y nodejs

RUN echo "deb http://ppa.launchpad.net/rmescandon/yq/ubuntu xenial main" | tee /etc/apt/sources.list.d/yq.list \ 
    && curl -sL  "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9a2d61f6bb03ced7522b8e7d6657dbe0cc86bb64" | apt-key add - \
    && echo "deb http://ubuntu.bigbluebutton.org/xenial-200-dev bigbluebutton-xenial main " | tee /etc/apt/sources.list.d/bigbluebutton.list \
    && curl -sL http://ubuntu.bigbluebutton.org/repo/bigbluebutton.asc | apt-key add - \
    && apt-get update \
    && (ACCEPT_EULA=y apt-get -y install yq bbb-webrtc-sfu bbb-html5; exit 0)

RUN rm /var/lib/dpkg/info/bbb-html5.postinst \
 && rm /var/lib/dpkg/info/bbb-webrtc-sfu.postinst \
 && apt-get install -y

RUN cd /usr/share/meteor/bundle/programs/server && npm install

WORKDIR /usr/share/meteor/bundle/

EXPOSE 3000

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
          && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
            && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY docker-entrypoint.sh ./

COPY settings-production.json.tmpl ./

CMD [ "node" "index.js" ]

