FROM buildpack-deps:focal
ARG IDE_NODE_VERSION=10.20.1
ARG version=latest
ARG GITHUB_TOKEN
ARG USERNAME=guru
ARG USER_UID=1000
ARG USER_GID=${USER_UID}
ARG WORKSPACE_PATH=/workspace

ENV DEBIAN_FRONTEND=noninteractive \
    IDE_NODE_VERSION=${IDE_NODE_VERSION} 

RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog \
    && apt-get install --no-install-recommends -y \
        git sudo procps lsb-release dnsutils jq libx11-dev libxkbfile-dev \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y;

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME} \
    && chmod g+rw /home \
    && mkdir -p ${WORKSPACE_PATH} \
    && chown -R ${USERNAME}:${USERNAME} ${WORKSPACE_PATH}

ENV NVM_DIR=/home/${USERNAME}/.nvm \
    IDE_NODE_VERSION=${IDE_NODE_VERSION}

USER ${USERNAME}
WORKDIR /home/${USERNAME}

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.3/install.sh | bash \
    && . "$NVM_DIR/nvm.sh" \
    && nvm install ${IDE_NODE_VERSION} \
    && npm install -g yarn yo \
        generator-theia-extension \
        @theia/generator-plugin \
        generator-code typescript \
        ovsx \
        vsce

WORKDIR ${WORKSPACE_PATH}

ENV DEBIAN_FRONTEND=dialog
# configure Theia
ENV SHELL=/bin/bash 
EXPOSE 3000

ENTRYPOINT [ "bash" ]
