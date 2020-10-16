ARG DOCKER_VERSION=7.9.0

FROM docker.elastic.co/elasticsearch/elasticsearch:$DOCKER_VERSION

LABEL maintainer="Saagie"
LABEL maintainerEmail="yann.petit@saagie.com"

# Install nginx 
RUN yum install -y epel-release && \
    yum install -y nginx && \
    yum clean all

# Expose port
EXPOSE 8200
EXPOSE 8300

# Modify cong nginx
COPY resources/nginx.conf /etc/nginx/nginx.conf

# Define entrypoint
COPY resources/entrypoint.sh /entrypoint.sh

# Single Node config ENV VAR for ES
# ENV discovery.type single-node only set for root not elasticsearch user and as it contains a  (dot) it's name is not bash rules compliant so use config file instead
COPY resources/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

# uses tini as entrypoint 
ENTRYPOINT ["/tini", "/entrypoint.sh"]