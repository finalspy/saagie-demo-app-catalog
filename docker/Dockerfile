ARG DOCKER_VERSION=7.9.0
FROM docker.elastic.co/elasticsearch/elasticsearch:$DOCKER_VERSION

LABEL maintainer="Saagie"
LABEL maintainerEmail="yann.petit@saagie.com"

# Install nginx 
RUN yum install -y epel-release && \
    yum install -y nginx && \
    yum clean all

# Modify cong nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 8200
EXPOSE 8300

# Define entrypoint
COPY entrypoint.sh /entrypoint.sh

ENV discovery.type single-node

ENTRYPOINT ["/entrypoint.sh"]