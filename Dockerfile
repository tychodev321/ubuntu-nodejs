# https://hub.docker.com/_/ubuntu
FROM ubuntu:22.04

LABEL maintainer=""

ENV NODEJS_VERSION=18.0.0 \
    NPM_VERSION=10.1.0 \
    YARN_VERSION=1.22.19 \
    PATH=$HOME/.local/bin/:$PATH \
    npm_config_loglevel=warn \
    npm_config_unsafe_perm=true

# Install Base Tools
RUN apt update -y && apt upgrade -y \
    && apt install -y unzip \
    && apt install -y gzip \
    && apt install -y tar \
    && apt install -y wget \
    && apt install -y curl \
    && apt install -y jq \
    && apt install -y sudo \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

# Create .ssh directory and add Github SSH Keys
RUN mkdir -p -m 0700 /root/.ssh \
    && curl --silent https://api.github.com/meta | jq --raw-output '"github.com "+.ssh_keys[]' >> /root/.ssh/known_hosts \
    && chmod 600 /root/.ssh/known_hosts

# Install Node and NPM
RUN apt update -y && apt upgrade -y \
    && curl -s https://deb.nodesource.com/setup_18.x | sudo bash - \
    && apt install -y nodejs \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install Yarn
RUN npm install --global yarn@${YARN_VERSION} \
    && npm config set prefix /usr/local
    
RUN echo "node version: $(node --version)" \
    && echo "npm version: $(npm --version)" \
    && echo "yarn version: $(yarn --version)"

# USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
