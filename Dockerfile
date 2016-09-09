FROM    ubuntu

# Here we use several hacks collected from https://github.com/gliderlabs/docker-alpine/issues/11:
# # 1. install GLibc (which is not the cleanest solution at all)


# Build variables
ENV     FILEBEAT_VERSION 1.2.3
ENV     FILEBEAT_URL https://download.elastic.co/beats/filebeat/filebeat-${FILEBEAT_VERSION}-x86_64.tar.gz

# Environment variables
ENV     FILEBEAT_HOME /opt/filebeat-${FILEBEAT_VERSION}-x86_64
ENV     PATH $PATH:${FILEBEAT_HOME}

WORKDIR /opt/

RUN     apt-get update && apt-get -y install python curl

RUN     curl -sL ${FILEBEAT_URL} | tar xz -C .
ADD     filebeat.yml ${FILEBEAT_HOME}/
ADD     docker-entrypoint.sh    /entrypoint.sh
RUN     chmod +x /entrypoint.sh

ENTRYPOINT  ["/entrypoint.sh"]
CMD         ["start"]
