FROM ubuntu:bionic

ARG peq_release_tag=latest
ENV PEQ_RELEASE_TAG=$peq_release_tag

USER root

ENV EQEMU_HOME=/home/eqemu
ENV PEQ_QUESTS_DIR=/home/eqemu/quests

ENV DEBIAN_FRONTEND=noninteractive

# Install basic packages
RUN apt-get update -y && \
    apt-get install -y bash curl wget git

# Set eqemu user
RUN groupadd eqemu && \
    useradd -g eqemu -d $EQEMU_HOME eqemu && \
    mkdir -p $EQEMU_HOME && \
    mkdir -p $PEQ_QUESTS_DIR

# Clone quests
RUN git clone https://github.com/ProjectEQ/projecteqquests.git $PEQ_QUESTS_DIR
RUN if [ "$PEQ_RELEASE_TAG" != "latest" ]; then cd $PEQ_QUESTS_DIR; git fetch --all --tags --prune; git checkout tags/$PEQ_RELEASE_TAG; fi;

# Cleanup unneeded packages
RUN apt-get remove -y git wget curl && \
    apt-get autoremove -y && \
    apt-get clean cache

RUN chown -R eqemu:eqemu /home/eqemu

WORKDIR /home/eqemu
USER eqemu

VOLUME /home/eqemu/quests

ENTRYPOINT ["/usr/bin/tail", "-f", "/dev/null"]