# DHBW LaTeX Template - Ultimate Edition

A professional, minimal, and fast LaTeX template for DHBW Karlsruhe project and bachelor theses.

**🚀 Build now: Docker • Local • GitHub Actions • VS Code • Overleaf**

## 📋 Table of Contents

- [Quick Start](#quick-start)
- [Installation Guides](#installation-guides)
- [Building Your PDF](#building-your-pdf)
- [Features](#features)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [Credits](#credits)

---

## ⚡ Quick Start - Like Overleaf

### Simplest Workflow: Press Ctrl+Enter to Build

```bash
# Clone repository
git clone https://github.com/mrettig/DHBW_LaTeX_Vorlage.git
cd DHBW_LaTeX_Vorlage

# Open in VS Code
code .
```

**Then in VS Code:**
1. Open `main.tex`
2. Press **Ctrl+Enter** (or click the play button ▶️)
3. Wait 2-3 minutes
4. PDF appears automatically

✨ That's it! No `make` commands, no latexmk installation needed.

### Alternative Workflows

Want to use Docker directly or Overleaf instead?

| Method | Setup Time | Command |
|--------|-----------|---------|
| **Docker Compose** | 1 min | `docker-compose up` |
| **GitHub Actions** | 0 min | Push → auto-builds |
| **Overleaf** | Instant | Upload files |

**→ See [INSTALLATION.md](INSTALLATION.md) for detailed guides**

---

## 📚 Installation Guides

Choose your platform and preferred workflow:

### Windows Users
- **Option 1:** Install MiKTeX/TeX Live locally + VS Code → [Guide](INSTALLATION.md#windows)
- **Option 2:** Use Docker Desktop (recommended) → [Docker Guide](DOCKER.md)
- **Option 3:** Use VS Code Dev Container → [Dev Setup](INSTALLATION.md#vs-code-dev-container)
- **Option 4:** Upload to Overleaf → [Overleaf Setup](INSTALLATION.md#overleaf)

### Linux Users
- **Option 1:** Install texlive packages + latexmk → [Guide](INSTALLATION.md#linux)
- **Option 2:** Use Docker → [Docker Guide](DOCKER.md)
- **Option 3:** Use VS Code Dev Container → [Dev Setup](INSTALLATION.md#vs-code-dev-container)

### macOS Users
- **Option 1:** Install MacTeX → [Guide](INSTALLATION.md#macos)
- **Option 2:** Use Docker → [Docker Guide](DOCKER.md)
- **Option 3:** Use VS Code Dev Container → [Dev Setup](INSTALLATION.md#vs-code-dev-container)

### Cloud Solutions
- **GitHub Actions:** Auto-build on every push, download artifacts → [Info](DOCKER.md#github-actions)
- **Overleaf:** Cloud-based LaTeX editor → [Setup](INSTALLATION.md#overleaf)

---

## 🔨 Building Your PDF

### Primary Method: VS Code (Like Overleaf)

```
Open main.tex → Press Ctrl+Enter → PDF builds automatically in 2-3 minutes
```

No installation needed - Docker handles everything!

### Alternative: Docker Directly

```bash
# Use docker-compose (simplest)
docker-compose up

# Or manual docker commands
docker build -t dhbw-latex .
docker run --rm -v $(pwd):/work dhbw-latex
```

### Automatic: GitHub Actions

Push to GitHub → PDF builds automatically → Download from "Artifacts" tab

**→ Detailed workflows in [DEVELOPMENT.md](DEVELOPMENT.md)**

---

## ✨ Features

- ✅ **Minimal & Fast** - Only required packages, <5 min compile time
- ✅ **Docker Ready** - Build without local LaTeX installation
- ✅ **CI/CD Included** - GitHub Actions auto-build
- ✅ **Modern Packages** - Up-to-date, no conflicts
- ✅ **German Template** - Optimized for DHBW Karlsruhe
- ✅ **Flexible** - Seminar papers, bachelor's theses, project reports
- ✅ **Well-Documented** - Step-by-step guides for all platforms
- ✅ **Developer-Friendly** - VS Code extensions, spell checking, Git integration

### What's Included

- **Bibliography:** APA style citations with biblatex + biber
- **Code Highlighting:** Syntax highlighting with minted
- **Acronyms:** Automatic abbreviation list generation
- **Typography:** Professional margins and formatting
- **Figures & Tables:** Full customization
- **Headers/Footers:** Page numbers and custom styling

---

## 📁 Project Structure

```
DHBW_LaTeX_Vorlage/
├── config/                     # Configuration files
│   ├── config.tex             # User variables (title, author, dates)
│   ├── preamble.tex           # Document class & package setup
│   ├── titlepage.tex          # Cover page template
│   ├── declaration.tex        # Honor statement
│   ├── blockingNotice.tex     # Confidentiality notice (optional)
│   ├── references.tex         # Bibliography config
│   ├── logo_dhbw.pdf          # DHBW logo
│   └── logo_united-internet.pdf # Company logo template
├── text/                      # Your content
│   ├── 01-chapter.tex         # Chapter 1
│   ├── 02-chapter.tex         # Chapter 2
│   ├── 03-chapter.tex         # Chapter 3
│   ├── 04-chapter.tex         # Chapter 4
│   ├── apendix.tex            # Appendix
│   └── acronym.tex            # Abbreviations
├── assets/                    # Media files
│   ├── images/               # Figures and graphics
│   ├── appendix/             # Additional PDFs/documents
│   └── literature/
│       └── bibliography.bib  # BibTeX references
├── Dockerfile                 # Docker production build
├── docker-compose.yml        # Docker development setup
├── Makefile                  # Build automation
├── main.tex                  # Master document (don't edit)
└── README.md                 # This file
```

---

## 🚀 Getting Started

### Step 1: Configure Your Document
Edit `config/config.tex`:
```latex
\newcommand{\thesisTitle}{Your Thesis Title}
\newcommand{\author}{Your Name}
\newcommand{\matrikelNumber}{123456}
% ... more options
```

### Step 2: Write Your Content
Edit files in `text/` directory:
- `01-chapter.tex` through `04-chapter.tex` for main content
- `apendix.tex` for appendices
- `acronym.tex` for abbreviations

### Step 3: Add Bibliography
Add references to `assets/literature/bibliography.bib`:
```bibtex
@book{Smith2020,
  author  = {John Smith},
  title   = {Great Title},
  year    = {2020},
  publisher = {Publisher}
}
```

### Step 4: Build
See [Building Your PDF](#building-your-pdf) section above

---

## 🔧 Configuration

### Document Type
Enable/disable features in `config/preamble.tex`:

```latex
\newtoggle{seminararbeit}    % Toggle seminar paper mode
\newtoggle{blockingnotice}   % Include confidentiality notice
```

### Language
Default is German (ngerman). Change in `config/preamble.tex`:

```latex
\usepackage[english, ngerman]{babel}  % English first, German default
```

### Fonts & Styling
Uncomment options in  `config/preamble.tex` for:
- Different fonts (TeX Gyre, Arial, etc.)
- Symmetric margins (portfolio mode)
- Custom colors and layouts

---

## 📖 Documentation

- **[INSTALLATION.md](INSTALLATION.md)** - Platform-specific setup
- **[DOCKER.md](DOCKER.md)** - Docker architecture and troubleshooting
- **[DEVELOPMENT.md](DEVELOPMENT.md)** - Local workflow and best practices
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Template improvements
- **[CHANGELOG.md](CHANGELOG.md)** - Version history

---

## 🐛 Troubleshooting

### PDF won't build
- Check `main.log` for LaTeX errors
- Verify bibliography.bib is in `assets/literature/`
- See [INSTALLATION.md](INSTALLATION.md#troubleshooting)

### Docker issues
- See [DOCKER.md](DOCKER.md#troubleshooting)

### Package missing
- Ensure TeX Live includes all packages (documented in Dockerfile)
- Add custom packages via Dockerfile if needed

---

## 🤝 Contributing

Have improvements? We welcome contributions!

1. Fork this repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

---

## 📋 Credits

This template builds on years of development and refinement:

### History & Contributors

| Year | Contributor | Institution | Contribution |
|------|-------------|-------------|--------------|
| **2018** | Daniel Spitzer | DHBW Lörrach | Created the original LaTeX template for academic work |
| **2021** | Katja Wengler | DHBW Karlsruhe (ZWI) | Adapted and enhanced the template for Karlsruhe campus |
| **2024** | Manuel Rettig | - | Maintained codebase, system improvements |
| **2024** | Claude (Anthropic) | - | Docker integration, GitHub Actions CI/CD, comprehensive documentation |

### Acknowledgments

- **DHBW** for the institutional framework
- **LaTeX Community** for the excellent tools and packages
- **TeX Live** maintainers for the LaTeX distributions
- All contributors who have improved this template

See [LICENSE.txt](LICENSE.txt) for full legal attribution.

---

## 📄 License

**MIT License** - Free to use, modify, and distribute

This template is provided under the MIT License for educational and professional use at DHBW institutions. See [LICENSE.txt](LICENSE.txt) for details.

**Key points:**
- Freely use for DHBW theses, seminar papers, and projects
- Modify and adapt to your needs
- Share improvements with the community
- Maintain attribution to original authors

For the full license text and complete contributor history, see [LICENSE.txt](LICENSE.txt).

---

## 🔗 Related Links

- [DHBW Germany](https://www.dhbw.de/)
- [DHBW Karlsruhe](https://www.karlsruhe.dhbw.de/)
- [LaTeX Documentation](https://en.wikibooks.org/wiki/LaTeX)
- [Overleaf](https://www.overleaf.com/)
- [BibTeX Reference](http://www.ctan.org/pkg/biblatex)

---

**Made with ❤️ for DHBW Karlsruhe**

Have questions? Check the [documentation](#documentation) or open an issue on GitHub.
