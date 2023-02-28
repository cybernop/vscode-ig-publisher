FROM ghcr.io/cybernop/vscode-fsh-sushi:3.0.0-beta.1-alpine AS  alpine

RUN apk update \
    && apk add --no-cache \
    openjdk17-jdk \
    ruby-dev \
    msttcorefonts-installer \
    fontconfig

RUN gem install jekyll
RUN update-ms-fonts

RUN wget -P /workspaces https://raw.githubusercontent.com/HL7/ig-publisher-scripts/main/_updatePublisher.sh \
    && chmod a+x /workspaces/_updatePublisher.sh \
    && sed -i 's/#!\/bin\/bash/#!\/bin\/sh/g' /workspaces/_updatePublisher.sh


FROM ghcr.io/cybernop/vscode-fsh-sushi:3.0.0-beta.1-ubuntu AS  ubuntu

RUN apt update \
    && apt install -y \
    openjdk-17-jdk \
    ruby-full \
    build-essential \
    zlib1g-dev

RUN gem install jekyll

RUN wget -P /workspaces https://raw.githubusercontent.com/HL7/ig-publisher-scripts/main/_updatePublisher.sh \
    && chmod a+x /workspaces/_updatePublisher.sh
