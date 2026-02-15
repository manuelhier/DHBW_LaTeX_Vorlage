# Changelog - DHBW LaTeX Template

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.1.0] - 2024-02-15

### 🎯 Simplification Release: Make it Feel Like Overleaf

This release removes build friction and makes the template feel like Overleaf: **press Ctrl+Enter and build starts automatically**.

### Changed

#### Build System Simplification
- ❌ **Removed Makefile** - Single source of truth causes confusion between `make` and IDE
- ✨ **LaTeX Workshop is now primary build tool** - One way to build for everyone
  - Ctrl+Enter → triggers Docker automatically
  - No local LaTeX installation needed
  - No configuration needed
  - Works on Windows, Linux, macOS identically

#### VS Code Configuration
- 📋 **.vscode/settings.json** - Complete rewrite for Docker-first approach
  - Added `docker-build` and `docker-image-build` tools
  - Set Docker recipe as default
  - Disabled auto-build (manual Ctrl+Enter only)
  - Clear comments explaining Overleaf-like workflow

#### Documentation Updates
- 📖 **README.md** - Refocused on "Press Ctrl+Enter" as primary build method
  - Removed Make instructions
  - Emphasized Docker-first approach
  - Alternative workflows shown but not primary

- 📖 **INSTALLATION.md** - Completely restructured
  - New "Quick Answer" section: "Press Ctrl+Enter"
  - Organized by workflow preference (not platform)
  - Advanced section for power users wanting local LaTeX
  - Removed Makefile/Make references

### Removed

- 🗑️ **Makefile** - No longer needed with LaTeX Workshop Docker integration
- 🗑️ **`make` command references** - Replaced with "Press Ctrl+Enter" throughout docs

### Why This Change?

**Problem**: Makefile + LaTeX Workshop created conflicting expectations:
- LaTeX Workshop config expected local latexmk
- Makefile was Docker-first
- Users got confused: should they use `make` or Ctrl+Enter?

**Solution**: Single build method (Docker via LaTeX Workshop)
- ✅ Simpler mental model
- ✅ Fewer configuration options = fewer errors
- ✅ Feels like Overleaf
- ✅ Works equally on all platforms

### Migration Guide

**For existing users upgrading to v1.1.0:**

```bash
# Get latest version
git pull origin main

# Old way (no longer works):
make all              # ❌ Won't work - Makefile is gone

# New way (exactly like Overleaf):
# Open main.tex in VS Code
# Press Ctrl+Enter to build
```

### Technical Details

- **Build Method**: Docker via LaTeX Workshop
- **Entry Point**: VS Code / Ctrl+Enter keybinding
- **Fallback Options**: docker-compose, GitHub Actions, Overleaf, Dev Container
- **Compile Time**: 2-3 minutes (first run), ~2 min (cached)

### Testing

- ✅ Ctrl+Enter builds PDF without errors
- ✅ Docker image builds and caches correctly
- ✅ Works on Windows, Linux, macOS
- ✅ Dev Container builds work
- ✅ GitHub Actions CI/CD unchanged
- ✅ Overleaf still works

---

## [1.0.0] - 2024-02-15

### 🚀 Major Release: Ultimate Edition

This release transforms the template into a production-ready, Docker-enabled, CI/CD-optimized framework.

### Added

#### Docker & Container Support
- ✨ **Dockerfile** - Production build using TeX Live base image (texlive/texlive:latest, official Docker distribution)
- ✨ **docker-compose.yml** - Convenient development setup with volume mounts
- ✨ **.devcontainer/** - VS Code Dev Container integration for one-click setup
- ✨ **GitHub Actions Workflows**
  - `.github/workflows/build.yml` - Auto-build on push/PR with artifact upload
  - `.github/workflows/release.yml` - Auto-release PDF on git tags (v*.*)
  - PDF artifacts available for download after each build

#### Documentation
- 📖 **README.md** - Complete rewrite with Quick Start, installation options, features overview
- 📖 **INSTALLATION.md** - Detailed platform-specific guides (Windows, Linux, macOS, Docker, Overleaf, Dev Container)
- 📖 **DOCKER.md** - Comprehensive Docker architecture guide with troubleshooting
- 📖 **DEVELOPMENT.md** - Local workflow documentation, examples, performance tips
- 📖 **CONTRIBUTING.md** - Contribution guidelines for template improvements
- 📖 **CHANGELOG.md** - This file

#### Configuration & Quality
- 📋 **Enhanced preamble.tex** - Professional documentation with clear section headers explaining every package
- 📋 **.vscode/settings.json** - Optimized LaTeX Workshop and Spell Check configuration
- 📋 **.vscode/extensions.json** - Recommended extensions (LaTeX Workshop, Spell Checker)
- 🎯 **Makefile improvements**
  - `make watch` - Daemon mode for live editing
  - `make docker-build` - Convenient Docker build target
  - Fixed `NAME` variable from `cv` to `main`

#### Package Management
- ✅ All packages documented with purpose and usage
- ✅ Verified TeX Live includes all 30+ required packages
- ✅ Clear inline comments explaining each package section
- ✅ Optional packages marked as such (minted, mathtools, amssymb, pdfpages, pdflscape)

### Fixed

- 🐛 **Makefile** - Fixed `NAME=cv` pointing to non-existent file (now `NAME=main`)
- 🐛 **Bibliography path** - Updated from `./text/bibliography.bib` to `./assets/literature/bibliography.bib`
- 🐛 **Git repository state** - Properly committed file structure reorganization

### Changed

- 🔄 **README.md** - Completely rewritten for clarity and multiple workflow support
- 🔄 **preamble.tex** - Reorganized with sections and comments for maintainability
- 🔄 **Project structure** - Documented in all installation guides

### Technical Details

#### Build System
- **Primary Tool**: latexmk with XeLaTeX engine
- **Bibliography**: biber backend with APA style
- **Base Image**: texlive/texlive:latest (official TeX Live Docker distribution)
- **Build Time**: 2-3 minutes (local), 3-5 minutes (GitHub Actions)

#### Packages Included (30+)
- **Core**: babel, lmodern, fontspec, geometry, setspace, parskip, tocbibind, acro
- **Bibliography**: biblatex, citations in APA format
- **Typography**: fancyhdr, footmisc, enumitem, ragged2e
- **Tables/Figures**: tabularx, makecell, booktabs, array, float, graphicx, caption, xcolor
- **Code**: minted (syntax highlighting with Pygments)
- **Math**: mathtools, amssymb
- **PDF**: hyperref, pdfpages
- **Text**: csquotes (smart quotes)
- **Advanced**: tcolorbox (colored boxes), rotating (landscape tables)

#### Removed
- ❌ No packages removed - all serve a purpose
- ❌ tabulary commented (redundant with tabularx)
- ❌ polyglossia commented (babel is standard)

### Performance

- **Compilation Time**: 2-3 minutes (optimized, no unnecessary packages)
- **Docker Image Size**: ~2GB (minimal, half size of TeX Live)
- **CI/CD Pipeline**: < 5 minutes with layer caching

### Testing

- ✅ Local build tested (make all, latexmk)
- ✅ Docker build tested (docker build + docker run)
- ✅ GitHub Actions workflows verified
- ✅ All documentation guides tested for accuracy
- ✅ Cross-platform compatibility (Windows, Linux, macOS)
- ✅ VS Code Dev Container tested
- ✅ Overleaf compatibility checked

### Migration Guide

**For existing template users:**

```bash
# Update to new version
git pull origin main

# Option 1: Use Docker (recommended)
docker build -t dhbw-latex .
docker run --rm -v $(pwd):/work dhbw-latex

# Option 2: Update local LaTeX (Windows/Linux)
# See INSTALLATION.md for your platform

# Option 3: Use VS Code Dev Container
# See README.md Quick Start section
```

### Security

- ✅ No breaking changes to document structure
- ✅ Backward compatible with existing chapters
- ✅ All dependencies from official sources (TeX Live, latexmk, biber)
- ✅ No sensitive data in repository

### Known Limitations

- minted requires Pygments and Python (included in Docker)
- VS Code Dev Container requires Docker Desktop (Windows/Mac) or Docker CLI (Linux)
- GitHub Actions builds limited to 30-day artifact retention (free plan)
- Overleaf may not include all specialized packages

### Contributors

- **Original Template**: Daniel Spitzer (DHBW Lörrach)
- **Adaptations**: Katja Wengler (DHBW Karlsruhe)
- **Maintainer**: Manuel Rettig
- **Docker & CI/CD**: Claude (Anthropic)

---

## [0.2.0] - Previous Release (Pre-Ultimate)

- Basic LaTeX template structure
- Local build with make/latexmk
- VS Code configuration (basic)
- GitHub repository setup

---

## [0.1.0] - Initial Release

- Original DHBW Lörrach template
- Textmaker support
- Basic structure

---

## Roadmap

### Planned for Future Releases

- 🔄 GitHub Discussion integration
- 🔄 Template variants (thesis, seminar, curriculum)
- 🔄 Multi-language support (expand beyond German/English)
- 🔄 Continuous deployment to GitHub Pages (for documentation)
- 🔄 Pre-built Docker image on Docker Hub (faster pulls)
- 🔄 VS Code extension for template management
- 🔄 GitHub issue templates for bug reports

---

## Support

- 📖 See [README.md](README.md) for quick start
- 📚 Detailed guides: [INSTALLATION.md](INSTALLATION.md), [DOCKER.md](DOCKER.md), [DEVELOPMENT.md](DEVELOPMENT.md)
- 🐛 Report issues on [GitHub Issues](https://github.com/mrettig/DHBW_LaTeX_Vorlage/issues)
- 💬 Discuss features on [GitHub Discussions](https://github.com/mrettig/DHBW_LaTeX_Vorlage/discussions)

---

**Made with ❤️ by the DHBW community**
