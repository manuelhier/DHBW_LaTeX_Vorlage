# Docker Guide - DHBW LaTeX Template

Comprehensive guide to using Docker for building the DHBW LaTeX template.

**Table of Contents:**
- [Why Docker](#why-docker)
- [Quick Start](#quick-start)
- [Docker Architecture](#docker-architecture)
- [Usage Methods](#usage-methods)
- [Advanced Configuration](#advanced-configuration)
- [Performance Optimization](#performance-optimization)
- [Troubleshooting](#troubleshooting)
- [GitHub Actions Integration](#github-actions-integration)

---

## Why Docker?

### Problems Docker Solves

1. **"It works for me"** - Works everywhere (Windows, Mac, Linux)
2. **No installation** - No need to install 3+ GB TeX Live
3. **Fast setup** - Get started in minutes, not hours
4. **Clean system** - No cluttering your OS with LaTeX packages
5. **Reproducible builds** - Everyone builds with same versions
6. **CI/CD ready** - Automatic builds on GitHub

### Comparison

| Aspect | Local Install | Docker |
|--------|--------------|--------|
| Setup time | 30+ minutes | 2-5 minutes |
| Disk usage | 2-5 GB | ~500 MB base + container |
| Cleanup | Manual | Automatic |
| Works on all OS | No* | Yes |
| Learning curve | Easy | Medium |

*Paths differ between Windows/Mac/Linux

---

## Quick Start

### Prerequisites
- Docker installed ([docker.com/get-docker](https://docker.com/get-docker))
- This Git repository
- Command line access (Terminal/PowerShell)

### Build in 3 Commands

```bash
# 1. Clone repository
git clone https://github.com/mrettig/DHBW_LaTeX_Vorlage.git
cd DHBW_LaTeX_Vorlage

# 2. Build Docker image (first time only)
docker build -t dhbw-latex .
# Subsequent runs will use cached image (~1 second)

# 3. Build PDF
docker run --rm -v $(pwd):/work dhbw-latex
# PDF appears in: main.pdf
```

**Duration:**
- First run: 2-5 minutes (building image)
- Subsequent runs: 2-3 minutes (compiling LaTeX)

---

## Docker Architecture

### Image: `latexcodes/ubuntu:latest`

This template uses the **latexcodes** base image - a minimal, optimized LaTeX environment.

#### Why latexcodes?

```
| LaTeX Distribution | Size     | Build Time | Use Case |
|-------------------|----------|------------|----------|
| Full TeX Live    | 5+ GB    | 10+ min    | Overkill  |
| BasicTeX (macOS) | 1.5 GB   | 5 min      | macOS only |
| **latexcodes**   | **2 GB** | **2 min**  | **This** ✓ |
| Minimal TeX      | 500 MB   | 1 min      | Fragile   |
```

#### What's Included in latexcodes

✅ All required packages:
- `babel`, `fontspec`, `geometry` (document basics)
- `biblatex`, `biber` (bibliography)
- `minted` (code highlighting)
- `acro` (acronyms)
- `tabularx`, `graphicx`, `tcolorbox` (tables/figures)
- `hyperref`, `fancyhdr` (PDF features)
- XeLaTeX engine

### Extended Dockerfile

Our `Dockerfile` extends latexcodes minimally:

```dockerfile
FROM latexcodes/ubuntu:latest
WORKDIR /work
ENTRYPOINT ["latexmk", "-xelatex", "-biber", "-pdf", "main.tex"]
```

**Design principles:**
- ✅ Minimal layers (fast builds)
- ✅ Single-purpose container
- ✅ Cached friendly for CI/CD
- ✅ Easy to extend if needed

### Dev Container Dockerfile

For VS Code Dev Container, we add development tools:

```dockerfile
FROM latexcodes/ubuntu:latest
RUN apt-get update && apt-get install -y \
    git curl wget vim nano  # Dev tools
```

---

## Usage Methods

### Method 1: Docker Run (Simplest)

```bash
docker build -t dhbw-latex .
docker run --rm -v $(pwd):/work dhbw-latex
```

**Windows (PowerShell):**
```powershell
docker run --rm -v ${PWD}:/work dhbw-latex
```

**Windows (CMD):**
```cmd
::First install Git for Windows or use WSL
docker run --rm -v %cd%:/work dhbw-latex
```

### Method 2: Docker Compose (Convenience)

```bash
docker-compose up
docker-compose down  # Cleanup
```

**Advantages:**
- Single command
- Automatic cleanup
- Mount configuration pre-set
- Easier for beginners

### Method 3: Makefile Integration

```bash
make docker-build      # Build image + run container
make all              # Traditional build (if latexmk installed locally)
```

### Method 4: Watch Mode (Live Rebuild)

```bash
docker run --rm -v $(pwd):/work dhbw-latex \
  sh -c 'latexmk -xelatex -biber -pdf -pvc main.tex'
```

Rebuilds automatically when files change.

### Method 5: VS Code Dev Container

```
Click "Reopen in Container" button → Build works automatically
```

See [INSTALLATION.md](INSTALLATION.md#vs-code-dev-container)

---

## Advanced Configuration

### Custom Build Targets

Build specific file (not always main.tex):

```bash
docker run --rm -v $(pwd):/work dhbw-latex \
  latexmk -xelatex -biber -pdf custom.tex
```

### Additional Packages (if needed)

If a required package is missing, extend the Dockerfile:

```dockerfile
FROM latexcodes/ubuntu:latest

# Add package
RUN tlmgr install <package-name>

WORKDIR /work
ENTRYPOINT ["latexmk", "-xelatex", "-biber", "-pdf", "main.tex"]
```

Then rebuild:

```bash
docker build -t dhbw-latex .
```

### Environment Variables

Control latexmk behavior:

```bash
docker run --rm \
  -v $(pwd):/work \
  -e LATEXMKOPTS="-interaction=nonstopmode" \
  dhbw-latex
```

### Persistent Container

Keep container running for multiple builds:

```bash
# Start container
docker run -it -v $(pwd):/work dhbw-latex bash

# Inside container
latexmk -xelatex -biber -pdf -pvc main.tex
# Edit files → automatic rebuild
# Ctrl+C to stop
```

### Volume Mounting Options

**Standard (read/write):**
```bash
-v $(pwd):/work          # Mount current directory
```

**Read-only (output only):**
```bash
-v $(pwd):/work:ro       # Mount as read-only
```

**Named volumes (persistent):**
```bash
docker volume create latex-build
docker run -v latex-build:/work dhbw-latex
```

---

## Performance Optimization

### 1. Layer Caching

Docker caches layers. First build slowest:

```
FROM latexcodes/ubuntu:latest      ← Cached (fast)
RUN tlmgr install custom           ← Cached if not modified
WORKDIR /work                      ← Cached (instant)
ENTRYPOINT ...                     ← Cached
```

**Tip:** Put least-changing commands first

### 2. Multi-stage Builds (Advanced)

```dockerfile
FROM latexcodes/ubuntu:latest AS compiler
WORKDIR /work
RUN latexmk -xelatex -biber -pdf main.tex

FROM scratch
COPY --from=compiler /work/main.pdf .
```

Result: Only PDF, no build files (~2 MB)

### 3. Cache Warming

Pre-build image to avoid first-run delay:

```bash
docker build -t dhbw-latex .          # Time cost: 1-2 min
# Now users run fast:
docker run --rm -v $(pwd):/work dhbw-latex  # ~2 min (compile only)
```

### 4. Parallel Builds (CI/CD)

GitHub Actions builds multiple documents:

```yaml
- name: Build Chapters
  run: |
    docker build -t dhbw-latex .
    docker run --rm -v $(pwd):/work dhbw-latex main.tex
    docker run --rm -v $(pwd):/work dhbw-latex chapter1.tex
    docker run --rm -v $(pwd):/work dhbw-latex chapter2.tex
```

---

## Troubleshooting

### ❌ "Cannot connect to Docker daemon"

**Windows/macOS:**
- Start Docker Desktop
- Wait for "Docker is running" indicator

**Linux:**
- Ensure docker daemon is running: `sudo systemctl start docker`
- Add user to docker group: `sudo usermod -aG docker $USER`
- Log out and back in

### ❌ "Permission denied: /work"

```bash
# Linux: Run with user permissions
docker run --rm \
  -v $(pwd):/work \
  -u $(id -u):$(id -g) \
  dhbw-latex
```

### ❌ "Volume mount not working on Windows"

**PowerShell (correct):**
```powershell
docker run -v ${PWD}:/work dhbw-latex
```

**CMD (broken):**
```cmd
::This doesn't work - use PowerShell or Git Bash
docker run -v %cd%:/work dhbw-latex
```

**WSL (works):**
```bash
wsl cd and run commands inside WSL
```

### ❌ "main.pdf not created"

```bash
# Check build output
docker run -it -v $(pwd):/work dhbw-latex bash
# Inside container:
latexmk -xelatex -biber -pdf main.tex
# Check for errors in output
```

### ❌ "Package not found - minted colors error"

Pygments (required for minted) might be missing:

```dockerfile
# Add to Dockerfile:
RUN apt-get update && apt-get install -y python3-pygments
```

### ❌ "DNS resolution failed" (network issues)

```bash
# Check docker network
docker network inspect bridge

# Rebuild without cache
docker build --no-cache -t dhbw-latex .
```

### ❌ "Out of disk space"

Docker can consume disk with large images/containers:

```bash
# Clean up unused images
docker system prune -a

# Remove container explicitly
docker run --rm ...  # --rm flag auto-removes

# Check disk usage
docker system df
```

### Debug Mode

```bash
# Interactive shell in container
docker run -it -v $(pwd):/work dhbw-latex bash

# Inside container, run build manually
latexmk -xelatex -interaction=nonstopmode -file-line-error -biber -pdf main.tex

# Check logs
ls -la main.log
tail -50 main.log
```

---

## GitHub Actions Integration

### Automatic Builds on Push

See `.github/workflows/build.yml` for the workflow that:

✅ Builds Docker image on every push
✅ Compiles PDF in container
✅ Uploads PDF artifact
✅ Comments PR with download link
✅ Caches layers for speed

**Usage:**
```bash
git push origin main
# → Automatic build starts
# → Check "Actions" tab for status
# → Download PDF from "Artifacts"
```

### Automatic Releases on Tags

See `.github/workflows/release.yml` for the workflow that:

✅ Builds PDF on git tag (e.g., `v1.0.0`)
✅ Creates GitHub Release
✅ Attaches PDF to release
✅ Generates release notes

**Usage:**
```bash
git tag v1.0.0
git push origin v1.0.0
# → Release created automatically
# → PDF downloadable from Releases page
```

### Local Simulation of CI/CD

Test GitHub Actions locally with [act](https://github.com/nektos/act):

```bash
# Install act
brew install act  # macOS
# Or download from GitHub

# Run workflow locally
act push          # Simulate push
act
```

---

## Performance Benchmarks

**Compile times (main.tex, 100+ pages):**

| Method | First Run | Cached |
|--------|-----------|--------|
| Docker (clean) | 3-5 min | 2-3 min |
| Docker Compose | 3-5 min | 2-3 min |
| GitHub Actions | 5-7 min | 3-5 min |
| Dev Container | 10+ min | 2-3 min |
| Local (TeX Live) | 2-3 min | 1-2 min |

**Notes:**
- First run includes image pull/build
- Cached runs skip Docker setup
- GitHub Actions slower due to VM startup
- Dev Container slower initially due to image build, faster thereafter

---

## Best Practices

1. ✅ **Always use `--rm` flag**
   ```bash
   docker run --rm ...  # Auto-cleanup after build
   ```

2. ✅ **Use docker-compose for development**
   ```bash
   docker-compose up    # Simpler, cleaner
   ```

3. ✅ **Rebuild image rarely**
   ```bash
   # Rebuild when Dockerfile changes
   docker build -t dhbw-latex .

   # But reuse for multiple builds
   docker run ... dhbw-latex
   docker run ... dhbw-latex
   ```

4. ✅ **Pin versions in production**
   ```dockerfile
   FROM latexcodes:ubuntu:latest  # Or specific version hash
   ```

5. ✅ **Use Dev Container for development**
   - Fastest local iteration
   - IDE integration
   - One-click setup

---

## Resources

- [Docker Docs](https://docs.docker.com/)
- [latexcodes Registry](https://hub.docker.com/r/latexcodes/ubuntu)
- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [LaTeX Workshop (VS Code)](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)

---

**Next Steps:**
- Try [Quick Start](#quick-start)
- Set up GitHub Actions for automatic builds
- See [DEVELOPMENT.md](DEVELOPMENT.md) for workflow tips
