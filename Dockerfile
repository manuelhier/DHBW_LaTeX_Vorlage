# DHBW LaTeX Template - Production Build
# Uses minimal latexcodes base image for fast, optimized builds
# Image size: ~2GB (vs 5GB+ for full TeX Live)
# Recommended for CI/CD, Docker builds, and container-based workflows

FROM latexcodes/ubuntu:latest

# Set working directory for build
WORKDIR /work

# Verify essential packages are present (biblatex, biber, minted, fontspec)
# These should be included in latexcodes, but document for clarity
# Comment: latexcodes provides:
# - Full TeX Live with common packages
# - biber (bibliography processor)
# - Fonts and fontspec support for XeLaTeX
# - minted (code highlighting) - requires Pygments

# If additional packages needed, uncomment and add below:
# RUN tlmgr install <package-name>

# Build the PDF using latexmk with XeLaTeX and biber
# Options:
#  -xelatex: Use XeLaTeX engine (handles fontspec better)
#  -biber: Use biber for bibliography processing
#  -pdf: Generate PDF output
ENTRYPOINT ["latexmk", "-xelatex", "-biber", "-pdf", "main.tex"]

# Default target (can be overridden with: docker run ... dhbw-latex main.tex)
CMD []
