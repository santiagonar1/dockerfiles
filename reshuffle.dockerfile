FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

ARG USERNAME=mpi-runner
ARG USER_UID=1000
ARG USER_GID=1000

RUN apt update -y && apt upgrade -y
RUN apt install -y build-essential \
    cmake \
    clang \
    libc++-dev \
    libc++abi-dev \
    python3 \
    python3-pip \
    python3-venv \
    python3-virtualenv

RUN apt install -y libopenmpi-dev \
    openmpi-bin

RUN apt install -y libopenblas-dev \
    liblapacke-dev \
    libscalapack-mpi-dev \
    libomp-dev

RUN useradd -m -s /bin/bash ${USERNAME}

USER ${USERNAME}
ENV PATH=/home/${USERNAME}/.local/bin:${PATH}
WORKDIR /home/${USERNAME}

RUN pip install conan --break-system-packages

RUN CC=gcc CXX=g++ conan profile detect --name=default
RUN CC=gcc CXX=g++ conan profile detect --name=gcc
RUN CC=clang CXX=clang++ conan profile detect --name=clang

RUN sed -i.bak -E 's|^(compiler\.cppstd\s*=\s*).*$|\1gnu20|' ~/.conan2/profiles/default \
    || echo -e "[settings]\ncompiler.cppstd=gnu20" >> ~/.conan2/profiles/default

RUN sed -i.bak -E 's|^(compiler\.cppstd\s*=\s*).*$|\1gnu20|' ~/.conan2/profiles/gcc \
    || echo -e "[settings]\ncompiler.cppstd=gnu20" >> ~/.conan2/profiles/gcc

RUN sed -i.bak -E 's|^(compiler\.cppstd\s*=\s*).*$|\1gnu20|' ~/.conan2/profiles/clang \
    || echo -e "[settings]\ncompiler.cppstd=gnu20" >> ~/.conan2/profiles/clang
    
RUN sed -i.bak -E 's/^(compiler\.libcxx\s*=\s*)libstdc\+\+11/\1libc++/' ~/.conan2/profiles/clang
