FROM ubuntu:22.10

LABEL maintainer=""

ENV NODEJS_VERSION=18.16.0 \
    NPM_VERSION=9.6.5 \
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
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install Node and NPM
RUN apt update -y && apt upgrade -y \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - \
    && apt install -y nodejs \
    && apt install -y npm \
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