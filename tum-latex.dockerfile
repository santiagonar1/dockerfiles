FROM texlive/texlive:latest

ARG INSTALLER_URL

# --- Install Git LFS in its own layer --------------------
RUN set -ex; \
    apt update; \
    apt install -y --no-install-recommends git git-lfs ca-certificates curl; \
    git lfs install --system --skip-smudge; \
    rm -rf /var/lib/apt/lists/*

# --- Fetch and install TUM LaTeX templates ---------------
RUN --mount=type=secret,id=gitlab_token \
    set -ex; \
    cd /tmp; \
    curl --fail --header "PRIVATE-TOKEN:$(cat /run/secrets/gitlab_token)" \
        ${INSTALLER_URL} --output tum-templates.tar.gz; \
    tar -xf tum-templates.tar.gz --strip-components=1; \
    bash install-linux.sh -y; \
    rm -rf *
