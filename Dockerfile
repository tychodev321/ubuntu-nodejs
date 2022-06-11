FROM registry.access.redhat.com/ubi9/ubi-minimal:9.0.0
# FROM redhat/ubi9/ubi-minimal:9.0.0

LABEL maintainer=""

ENV NODEJS_VERSION=16 \
    NPM_VERSION=8 \
    PATH=$HOME/.local/bin/:$PATH \
    npm_config_loglevel=warn \
    npm_config_unsafe_perm=true

# MicroDNF is recommended over YUM for Building Container Images
# https://www.redhat.com/en/blog/introducing-red-hat-enterprise-linux-atomic-base-image

RUN microdnf update -y \
    && microdnf install -y nodejs-${NODEJS_VERSION} \
    && microdnf install -y npm-${NPM_VERSION} \
    && microdnf clean all \
    && rm -rf /var/cache/* /var/log/dnf* /var/log/yum.*

RUN npm install --global yarn \
    && npm config set prefix /usr/local
    
RUN node --version && npm --version && yarn --version

# USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
