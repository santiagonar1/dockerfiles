FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

ARG USERNAME=mpi-runner
ARG USER_UID=1000
ARG USER_GID=1000

RUN apt update -y && apt upgrade -y
RUN apt install -y build-essential \
    cmake \
    clang \
    python3 \
    python3-pip \
    python3-venv \
    python3-virtualenv

RUN apt install -y libopenmpi-dev \
    openmpi-bin

RUN useradd -m -s /bin/bash ${USERNAME}

USER ${USERNAME}
ENV PATH=/home/${USERNAME}/.local/bin:${PATH}
WORKDIR /home/${USERNAME}

RUN pip install conan --break-system-packages

RUN CC=gcc CXX=g++ conan profile detect --name=default
RUN CC=gcc CXX=g++ conan profile detect --name=gcc
RUN CC=clang CXX=clang++ conan profile detect --name=clang
