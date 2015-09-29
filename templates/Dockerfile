FROM gitinsky/oracle-java-8:0.1.1
MAINTAINER Git In Sky <support@gitinsky.com>

ENV ES_PKG_NAME elasticsearch-1.4.2

RUN \
  apt-get install unzip && \
  cd / && \
  mkdir /config && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch && \
  wget https://dl.bintray.com/mitchellh/consul/0.5.0_linux_amd64.zip -O /tmp/consul.zip && \
  cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip && \
  wget https://dl.bintray.com/mitchellh/consul/0.5.0_web_ui.zip -O /tmp/webui.zip && \
  mkdir /ui && cd /ui && unzip /tmp/webui.zip && rm /tmp/webui.zip && mv dist/* . && rm -rf dist && \
  wget https://get.docker.io/builds/Linux/x86_64/docker-1.5.0 -O /bin/docker && \
  mkdir /etc/service/elasticsearch && \
  chmod +x /bin/docker

COPY elasticsearch_config.sh /opt/elasticsearch_config.sh
RUN chmod +x /opt/elasticsearch_config.sh
# install bigdesk plugin
RUN JAVA_HOME=/jdk1.8.0_40/ && \
    export JAVA_HOME && \
    /elasticsearch/bin/plugin -install lukas-vlcek/bigdesk
# remove config as we're going to mount it on run
RUN rm -v /elasticsearch/config/elasticsearch.yml
ADD ./run /etc/service/elasticsearch/run
#ADD ./consul.json /config/consul.json

#COPY consul.rb /etc/eye/consul.rb
#COPY elasticsearch.rb /etc/eye/elasticsearch.rb

EXPOSE 9200 9300 8300 8301 8301/udp 8302 8302/udp 8400 8500
