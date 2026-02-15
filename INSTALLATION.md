# Installation Guide - DHBW LaTeX Template

Choose your platform and preferred workflow below.

**Table of Contents:**
- [Windows](#windows)
- [Linux](#linux)
- [macOS](#macos)
- [VS Code Dev Container](#vs-code-dev-container)
- [Overleaf](#overleaf)
- [Docker](#docker)
- [Troubleshooting](#troubleshooting)

---

## Windows

### Option 1: Local Installation with MiKTeX

**Requirements:** Windows 10/11, ~2-3 GB disk space

1. **Download and Install MiKTeX**
   - Visit [miktex.org](https://miktex.org/)
   - Download "MiKTeX Installer" (~240 MB)
   - Run installer, choose "Install MiKTeX for all users"
   - Complete installation

2. **Install Biber (Bibliography Processing)**
   - Open Command Prompt as Administrator
   - Run: `tlmgr install biber`
   - Or: Download from [sourceforge.net/projects/biblatex-biber](https://sourceforge.net/projects/biblatex-biber/)

3. **Install Python + Pygments (for code highlighting)**
   - Download Python from [python.org](https://python.org)
   - During installation: **Check "Add Python to PATH"**
   - Open Command Prompt and run: `pip install pygments`

4. **Verify Installation**
   ```cmd
   latexmk --version        # Should show version info
   biber --version          # Should show biber version
   pygmentize -V            # Should show Pygments version
   ```

5. **Clone and Build**
   ```cmd
   git clone https://github.com/mrettig/DHBW_LaTeX_Vorlage.git
   cd DHBW_LaTeX_Vorlage
   make all                 # Requires Make (see below)
   ```

**Install GNU Make for Windows (if needed):**
- Option A: Install [Git for Windows](https://git-scm.com/) - includes make
- Option B: Use `latexmk -pdf main.tex` directly (no Make needed)

### Option 2: Local Installation with TeX Live

1. **Download TeX Live Installer**
   - Visit [tug.org/texlive](https://tug.org/texlive/)
   - Download `install-tl-windows.exe`
   - Run and complete installation

2. **Post-Installation**
   ```cmd
   tlmgr install biber
   pip install pygments
   ```

3. **Build**
   ```cmd
   latexmk -xelatex -biber -pdf main.tex
   ```

### Option 3: Docker (Recommended for Windows)

See [Docker](#docker) section below - avoids local LaTeX installation entirely.

### Option 4: VS Code Dev Container

See [VS Code Dev Container](#vs-code-dev-container) section below.

---

## Linux

### Ubuntu/Debian

1. **Install LaTeX and Dependencies**
   ```bash
   sudo apt-get update
   sudo apt-get install \
     texlive-latex-full \
     texlive-xetex \
     texlive-bibtex-extra \
     biber \
     latexmk \
     python3-pygments \
     git
   ```

2. **Verify Installation**
   ```bash
   latexmk --version
   biber --version
   pygmentize -V
   ```

3. **Clone and Build**
   ```bash
   git clone https://github.com/mrettig/DHBW_LaTeX_Vorlage.git
   cd DHBW_LaTeX_Vorlage
   make all
   ```

### Fedora/RHEL

```bash
sudo dnf install \
  texlive-scheme-full \
  texlive-xetex \
  biber \
  latexmk \
  python3-Pygments \
  git
```

Then continue with clone and build (same as Ubuntu).

### Arch Linux

```bash
sudo pacman -S \
  texlive-most \
  texlive-bin \
  biber \
  python-pygments \
  git
```

Then continue with clone and build.

### Alpine (Minimal Docker Alternative)

If building custom Docker image, Alpine's minimal packages:
```bash
apk add texlive texlive-xetex biber python3 py3-pygments
```

---

## macOS

### Option 1: MacTeX (Full Installation)

1. **Install MacTeX**
   - Download from [tug.org/mactex](https://www.tug.org/mactex/)
   - Or use Homebrew: `brew install --cask mactex`
   - Installation: ~3.5 GB

2. **Install Pygments**
   ```bash
   pip3 install pygments
   ```

3. **Verify**
   ```bash
   latexmk --version
   biber --version
   ```

4. **Clone and Build**
   ```bash
   git clone https://github.com/mrettig/DHBW_LaTeX_Vorlage.git
   cd DHBW_LaTeX_Vorlage
   make all
   ```

### Option 2: MacTeX via Homebrew

```bash
brew install mactex
brew install pygments
```

### Option 3: Docker (Lightweight Alternative)

See [Docker](#docker) section below.

---

## VS Code Dev Container

**One-click setup for Windows, Linux, and macOS**

### Prerequisites
- VS Code (free from [code.visualstudio.com](https://code.visualstudio.com))
- Dev Containers extension (install from VS Code extensions)
- Docker Desktop (if on Windows/macOS) or Docker CLI (Linux)

### Setup Steps

1. **Clone Repository**
   ```bash
   git clone https://github.com/mrettig/DHBW_LaTeX_Vorlage.git
   cd DHBW_LaTeX_Vorlage
   ```

2. **Open in VS Code**
   ```bash
   code .
   ```

3. **Reopen in Container**
   - VS Code will detect `.devcontainer/` folder
   - Click "Reopen in Container" button (bottom-left orange box)
   - OR Command Palette (Ctrl+Shift+P) → "Dev Containers: Reopen in Container"

4. **Wait for Setup**
   - First time: ~5-10 minutes (building Docker image)
   - Subsequent times: ~30 seconds (cached image)

5. **Build PDF**
   - LaTeX Workshop extension auto-installed
   - Press `Ctrl+Alt+B` to build
   - Or click "Build LaTeX project" in sidebar

6. **View PDF**
   - Press `Ctrl+Alt+V` to preview (or click tab)
   - Auto-updates on save

### What's Included
- LaTeX Workshop extension (syntax, commands, build)
- Spell Check extension (German + English)
- Git integration
- Full TeX Live + biber + Pygments

---

## Overleaf

### Upload to Overleaf (Cloud-based)

1. **ZIP the Repository**
   ```bash
   zip -r DHBW_LaTeX.zip DHBW_LaTeX_Vorlage/
   ```

2. **Create Overleaf Account**
   - Go to [overleaf.com](https://www.overleaf.com/)
   - Sign up or log in

3. **Create New Project**
   - Click "New Project" → "Upload Project"
   - Select `DHBW_LaTeX.zip`

4. **Configure Overleaf**
   - Set main document: `main.tex`
   - Compiler: XeLaTeX (Menu → Settings → Compiler)
   - Build should work automatically

### Limitations on Overleaf
- Free plan has compile limits + wait times
- May lack some newer packages
- Recommended for final submission backup only

### Download from Overleaf
- Click "Download PDF" to save compiled document

---

## Docker

### Prerequisites
- **Windows/macOS:** [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- **Linux:** Install Docker via package manager

### Option 1: Simple Docker Run

```bash
# Clone
git clone https://github.com/mrettig/DHBW_LaTeX_Vorlage.git
cd DHBW_LaTeX_Vorlage

# Build image
docker build -t dhbw-latex .

# Run (builds PDF)
docker run --rm -v $(pwd):/work dhbw-latex
```

**Windows (PowerShell):**
```powershell
docker run --rm -v ${PWD}:/work dhbw-latex
```

### Option 2: Docker Compose (Easier)

```bash
# In project directory
docker-compose up

# Clean up
docker-compose down
```

### Option 3: Rebuild Frequently

```bash
# Watch mode - rebuilds on file change
docker run --rm -v $(pwd):/work dhbw-latex sh -c 'latexmk -xelatex -biber -pdf -pvc main.tex'
```

### Verify Everything Works

```bash
docker run --rm -v $(pwd):/work dhbw-latex latexmk -v
```

See [DOCKER.md](DOCKER.md) for advanced usage and troubleshooting.

---

## Troubleshooting

### Common Issues

#### ❌ "latexmk: command not found"

**Windows:**
- Install TeX Live or MiKTeX (see above)
- Or use Docker instead
- Or use Overleaf

**Linux:**
```bash
sudo apt-get install latexmk     # Ubuntu/Debian
sudo dnf install latexmk         # Fedora
sudo pacman -S texlive-bin       # Arch
```

**macOS:**
```bash
brew install mactex  # or install from tug.org/mactex
```

#### ❌ "biber: command not found"

```bash
# Windows (MiKTeX)
tlmgr install biber

# Linux
sudo apt-get install biber

# macOS
brew install biber  # or via tlmgr
```

#### ❌ "pygmentize: command not found" (when using minted for code)

```bash
# Install Python first (if needed)
pip install pygments

# Or use without code highlighting (comment out minted in preamble)
```

#### ❌ "bibliography.bib: not found"

- Verify file is in `assets/literature/bibliography.bib`
- Check preamble.tex has correct path: `\addbibresource{./assets/literature/bibliography.bib}`
- Run `make clean && make all` to rebuild

#### ❌ PDF looks wrong / formatting broken

- Run full rebuild: `make distclean && make all`
- Check `main.log` for LaTeX errors
- Ensure all fonts are installed (especially if using custom fonts in preamble.tex)

#### ❌ Docker: "Cannot mount volume"

**Windows (PowerShell):**
```powershell
# Use correct volume syntax
docker run --rm -v ${PWD}:/work dhbw-latex
```

**Windows (CMD):**
```cmd
::Needs Git for Windows or WSL
docker run --rm -v %cd%:/work dhbw-latex
```

#### ❌ Docker: "Permission denied"

```bash
# Linux: Run as user, not root
docker run --rm -v $(pwd):/work -u $(id -u):$(id -g) dhbw-latex
```

#### ❌ Dev Container: Very slow first time

- Check Docker Desktop resources (Settings → Resources)
- Allocate more CPU/RAM if possible
- Wait for initial build (~5-10 min is normal)

#### ❌ "File not found" errors in build

- Ensure you're in the project root directory
- Check all file paths use `/` (forward slash), not `\`
- Verify no typos in `config/config.tex` filenames

### Getting More Help

- Check `main.log` for detailed error messages
- See [DOCKER.md](DOCKER.md) for Docker-specific issues
- See [DEVELOPMENT.md](DEVELOPMENT.md) for workflow questions
- Create an issue on GitHub

---

## Quick Reference

| Task | Windows | Linux | macOS |
|------|---------|-------|-------|
| Install LaTeX | MiKTeX installer | `apt-get install texlive-*` | MacTeX |
| Build locally | `make all`* | `make all` | `make all` |
| Build with Docker | `docker run -v %cd%:/work dhbw-latex` | `docker run -v $(pwd):/work dhbw-latex` | `docker run -v $(pwd):/work dhbw-latex` |
| Watch mode | latexmk -pvc | `make watch` | `make watch` |
| Clean build | `make distclean && make all` | `make distclean && make all` | `make distclean && make all` |

*Requires GNU Make - use `latexmk -pdf main.tex` directly if Make unavailable

---

**Next Steps:**
- Edit `config/config.tex` to customize your document
- Add content to `text/*.tex` files
- Build your PDF using your preferred method
- See [DEVELOPMENT.md](DEVELOPMENT.md) for detailed workflow
