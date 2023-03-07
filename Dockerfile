ARG SUSHI_VERSION=
FROM ghcr.io/cybernop/vscode-fsh-sushi:${SUSHI_VERSION}-alpine AS  alpine

RUN apk update \
    && apk add --no-cache \
    openjdk17-jdk \
    ruby-dev \
    msttcorefonts-installer \
    fontconfig

RUN gem install jekyll
RUN update-ms-fonts

RUN wget -P /workspaces https://raw.githubusercontent.com/HL7/ig-publisher-scripts/main/_updatePublisher.sh \
    && chmod a+x /workspaces/_updatePublisher.sh

RUN wget -P /workspaces https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar \
    && printf "#!/bin/bash\njava -jar ../validator_cli.jar -html-output validation.html fsh-generated/resources" >> /workspaces/validate.sh \
    && chmod a+x /workspaces/validate.sh


ARG SUSHI_VERSION=
FROM ghcr.io/cybernop/vscode-fsh-sushi:${SUSHI_VERSION}-ubuntu AS  ubuntu

RUN apt update \
    && apt install -y \
    openjdk-17-jdk \
    ruby-full \
    build-essential \
    zlib1g-dev

RUN gem install jekyll

RUN wget -P /workspaces https://raw.githubusercontent.com/HL7/ig-publisher-scripts/main/_updatePublisher.sh \
    && chmod a+x /workspaces/_updatePublisher.sh

RUN wget -P /workspaces https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar \
    && printf "#!/bin/bash\njava -jar ../validator_cli.jar -html-output validation.html fsh-generated/resources" >> /workspaces/validate.sh \
    && chmod a+x /workspaces/validate.sh
