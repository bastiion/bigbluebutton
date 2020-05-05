FROM ubuntu:16.04

RUN  apt-get update \
    && apt-get -y install wget

RUN echo "deb http://ubuntu.bigbluebutton.org/xenial-200-dev bigbluebutton-xenial main " | tee /etc/apt/sources.list.d/bigbluebutton.list \
 && wget http://ubuntu.bigbluebutton.org/repo/bigbluebutton.asc -O- | apt-key add - \
 && apt-get update \
 && ACCEPT_EULA=y apt-get -y install bbb-web; exit 0;

COPY bbb-web.postinst /tmp/

RUN cp /tmp/bbb-web.postinst /var/lib/dpkg/info/ \
 && apt-get install -y

COPY docker-entrypoint.sh ./

RUN mkdir -p /usr/share/tomcat7/logs/

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY bigbluebutton /var/lib/tomcat7/webapps/bigbluebutton

COPY turn-stun-servers.xml.tmpl ./

EXPOSE 3000

CMD [ "./docker-entrypoint.sh" ]
