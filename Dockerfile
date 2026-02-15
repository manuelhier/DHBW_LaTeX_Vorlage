# DHBW LaTeX Template - Production Build with TeX Live
# Uses docker.io/texlive/texlive base image (official TeX Live distribution)
# Image size: ~3GB full TeX Live with all packages preinstalled
# Recommended for CI/CD, Docker builds, and container-based workflows

FROM texlive/texlive:latest

# Set working directory for build
WORKDIR /work

# Ensure Pygments is available for minted (code highlighting)
RUN apt-get update && apt-get install -y python3-pygments && rm -rf /var/lib/apt/lists/*

# Build the PDF using latexmk with XeLaTeX and biber
# Options:
#  -xelatex: Use XeLaTeX engine (handles fontspec better)
#  -biber: Use biber for bibliography processing
#  -pdf: Generate PDF output
ENTRYPOINT ["latexmk", "-xelatex", "-biber", "-pdf", "main.tex"]

# Default target (can be overridden with: docker run ... dhbw-latex main.tex)
CMD []
