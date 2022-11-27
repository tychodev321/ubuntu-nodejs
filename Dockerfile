FROM registry.access.redhat.com/ubi9/ubi-minimal:9.0.0
# FROM redhat/ubi9/ubi-minimal:9.0.0

LABEL maintainer=""

ENV NODEJS_VERSION=16.14.0 \
    NPM_VERSION=8.3.1 \
    YARN_VERSION=1.22.19 \
    PATH=$HOME/.local/bin/:$PATH \
    npm_config_loglevel=warn \
    npm_config_unsafe_perm=true

# MicroDNF is recommended over YUM for Building Container Images
# https://www.redhat.com/en/blog/introducing-red-hat-enterprise-linux-atomic-base-image

# Install Node and NPM
RUN microdnf update -y \
    && microdnf install -y nodejs \
    && microdnf install -y npm \
    && microdnf clean all \
    && rm -rf /var/cache/* /var/log/dnf* /var/log/yum.*

# Install Yarn
RUN npm install --global yarn@${YARN_VERSION} \
    && npm config set prefix /usr/local
    
RUN echo "node version: $(node --version)" \
    && echo "npm version: $(npm --version)" \
    && echo "yarn version: $(yarn --version)" \
    && microdnf repolist

USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
