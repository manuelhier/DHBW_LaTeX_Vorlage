# VS Code Dev Container for DHBW LaTeX Template
# Extends TeX Live with development tools for VS Code integration

FROM texlive/texlive:latest-full

# Install additional development utilities and Pygments for minted
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    vim \
    nano \
    python3-pygments \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /work

# Configure bash as default shell
ENV SHELL=/bin/bash

# Verify LaTeX installation
RUN latexmk --version && biber --version
