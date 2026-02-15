NAME=main

# ============================================================================
# DEFAULT TARGET: Docker build (recommended)
# ============================================================================
# Use `make` or `make all` to build with Docker (no local LaTeX needed)

.PHONY: all
all: docker-build

# ============================================================================
# BUILD TARGETS
# ============================================================================

# Docker build - primary method (no local LaTeX installation needed)
.PHONY: docker-build
docker-build:
	@echo "Building with Docker (texlive base image)..."
	docker build -t dhbw-latex . && docker run --rm -v $$(pwd):/work dhbw-latex

# Local build - requires latexmk installed locally
.PHONY: local-build
local-build:
	@command -v latexmk >/dev/null 2>&1 || { echo "❌ latexmk not found. Install LaTeX or use 'make docker-build'"; exit 1; }
	latexmk -pdf ${NAME}.tex

# Watch mode - auto-rebuild on file change (requires local latexmk)
.PHONY: watch
watch:
	@command -v latexmk >/dev/null 2>&1 || { echo "❌ latexmk not found. Install LaTeX or use Docker"; exit 1; }
	latexmk -pdf -pvc ${NAME}.tex

# Docker compose build (alternative)
.PHONY: docker-compose-build
docker-compose-build:
	@echo "Building with docker-compose..."
	docker-compose up

# ============================================================================
# CLEANUP TARGETS
# ============================================================================

# Remove build artifacts (keep PDF)
.PHONY: clean
clean:
	rm -f ${NAME}.aux ${NAME}.bbl ${NAME}.bcf ${NAME}.fdb_latexmk ${NAME}.fls ${NAME}.log ${NAME}.out ${NAME}.run.xml ${NAME}.blg ${NAME}.toc *\~

# Clean + remove PDF
.PHONY: distclean
distclean: clean
	rm -f ${NAME}.pdf

# ============================================================================
# HELP TARGET
# ============================================================================

.PHONY: help
help:
	@echo "DHBW LaTeX Template - Build Commands"
	@echo ""
	@echo "PRIMARY (recommended):"
	@echo "  make                    - Build PDF with Docker (no LaTeX install needed)"
	@echo "  make docker-build       - Same as 'make' (explicit)"
	@echo "  make docker-compose-build - Build with docker-compose"
	@echo ""
	@echo "LOCAL (requires LaTeX installation):"
	@echo "  make local-build        - Build PDF locally with latexmk"
	@echo "  make watch              - Auto-rebuild on file change"
	@echo ""
	@echo "CLEANUP:"
	@echo "  make clean              - Remove build artifacts (keep PDF)"
	@echo "  make distclean           - Remove all artifacts including PDF"
	@echo ""
	@echo "For setup help, see README.md or INSTALLATION.md"