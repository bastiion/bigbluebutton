FROM bbb-common-web AS builder

RUN mkdir -p /root/tools \
 && cd /root/tools \
 && wget https://mirrors.cloud.tencent.com/gradle/gradle-3.5-bin.zip \
 && unzip gradle-3.5-bin.zip \
 && ln -s gradle-3.5 gradle

RUN mkdir -p /root/tools \
 && cd /root/tools \
 && wget https://github.com/grails/grails-core/releases/download/v3.3.8/grails-3.3.8.zip \
 && unzip grails-3.3.8.zip \
 && ln -s grails-3.3.8 grails

ENV PATH="/root/tools/gradle/bin:/root/tools/grails/bin:${PATH}"

ARG COMMON_VERSION=0.0.1-SNAPSHOT

COPY . /source

RUN cd /source \
 && find -name build.gradle -exec sed -i "s|\(.*org.bigbluebutton.*bbb-common-message[^:]*\):.*|\1:$COMMON_VERSIONr\"|g" {} \; \
 && find -name build.gradle -exec sed -i "s|\(.*org.bigbluebutton.*bbb-common-web[^:]*\):.*|\1:$COMMON_VERSION\"|g" {} \;

RUN mkdir -p ~/.m2/repository/cglib/cglib-nodep/2.2.2 \                                                                                                          
 && cd ~/.m2/repository/cglib/cglib-nodep/2.2.2 \                                                                                                                
 && wget https://repo.grails.org/grails/core/cglib/cglib-nodep/2.2.2/cglib-nodep-2.2.2.jar

RUN cd /source \
 && gradle resolveDeps \
 && grails war

FROM tomcat:7-jre8

WORKDIR $CATALINA_HOME

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
 && apt-get -y install imagemagick xpdf-utils netcat libreoffice ttf-liberation fonts-crosextra-carlito fonts-crosextra-caladea unzip procps \
 && wget https://cloudfront.debian.net/debian-archive/debian/pool/main/libj/libjpeg8/libjpeg8_8d-1+deb7u1_amd64.deb \
 && dpkg -i libjpeg8*.deb \
 && rm libjpeg8*.deb

RUN echo "deb http://ubuntu.bigbluebutton.org/xenial-200-dev bigbluebutton-xenial main " | tee /etc/apt/sources.list.d/bigbluebutton.list \
 && wget http://ubuntu.bigbluebutton.org/repo/bigbluebutton.asc -O- | apt-key add - \
 && apt-get update \
 && apt-get -y install bbb-swftools

# clean default webapps
RUN rm -r webapps/*

COPY --from=builder /source/build/libs/bigbluebutton-0.10.0.war webapps/bigbluebutton.war

RUN unzip -q webapps/bigbluebutton.war -d webapps/bigbluebutton \
 && rm webapps/bigbluebutton.war

COPY turn-stun-servers.xml.tmpl turn-stun-servers.xml.tmpl

COPY docker-entrypoint.sh /usr/local/bin/

CMD [ "dockerize", \
  "-template", "turn-stun-servers.xml.tmpl:webapps/bigbluebutton/WEB-INF/spring/turn-stun-servers.xml", \
  "docker-entrypoint.sh" ]
