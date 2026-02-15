# DHBW LaTeX Template - Production Build with TeX Live
# Uses docker.io/texlive/texlive base image (official TeX Live distribution)
# Image size: ~3GB full TeX Live with all packages preinstalled
# Recommended for CI/CD, Docker builds, and container-based workflows

FROM texlive/texlive:latest-full

# Set working directory for build
WORKDIR /work

# Ensure Pygments is available for minted (code highlighting)
RUN apt-get update && apt-get install -y python3-pygments && rm -rf /var/lib/apt/lists/*

# Build the PDF using latexmk with XeLaTeX
ENTRYPOINT ["latexmk", "-xelatex", "-interaction=nonstopmode", "-synctex=1", "-file-line-error", "-shell-escape", "main.tex"]

# Default target (can be overridden with: docker run ... dhbw-latex main.tex)
CMD []
