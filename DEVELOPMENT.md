# Development Guide - DHBW LaTeX Template

Workflows and best practices for working with the template.

**Table of Contents:**
- [IDE Setup](#ide-setup)
- [Local Development Workflow](#local-development-workflow)
- [Building](#building)
- [Bibliography Management](#bibliography-management)
- [Code Highlighting](#code-highlighting)
- [Performance Optimization](#performance-optimization)
- [Contributing](#contributing)
- [Tips & Tricks](#tips--tricks)

---

## IDE Setup

### VS Code (Recommended)

#### Extensions
1. **LaTeX Workshop** (James-Yu)
   - Syntax highlighting
   - Build commands
   - PDF preview
   - Snippets

2. **Spell Right** (Timon)
   - German spell checking (de_DE)
   - English spell checking (en_US)
   - Works inline

3. **GitHub Copilot** (optional)
   - AI-powered suggestions
   - Great for repetitive structures

#### Settings (.vscode/settings.json)

```json
{
  "latex-workshop.latex.autoBuild.run": "onSave",
  "latex-workshop.latex.tools": [
    {
      "name": "latexmk",
      "command": "latexmk",
      "args": [
        "-xelatex",
        "-interaction=nonstopmode",
        "-file-line-error",
        "-synctex=1",
        "-biber",
        "%DOCFILE%"
      ]
    }
  ],
  "latex-workshop.view.pdf.viewer": "tab",
  "editor.wordWrap": "on",
  "cSpell.language": "de,en"
}
```

#### Keybindings

Add to `.vscode/keybindings.json`:

```json
[
  {
    "key": "ctrl+l ctrl+b",
    "command": "latex-workshop.build"
  },
  {
    "key": "ctrl+l ctrl+c",
    "command": "latex-workshop.clean"
  },
  {
    "key": "ctrl+l ctrl+v",
    "command": "latex-workshop.view"
  }
]
```

### Texmaker

1. Download from [xm1math.net/texmaker](http://www.xm1math.net/texmaker/)
2. Open template folder
3. Options → Preferences → Master Document → Select `main.tex`
4. Build: Tools → Compile
5. View: Tools → View PDF

### Overleaf

1. Upload `.zip` to Overleaf
2. Set main file: `main.tex`
3. Menu → Compiler → "XeLaTeX"
4. Auto-compiles on save

---

## Local Development Workflow

### 1. Setup

```bash
# Clone repository
git clone https://github.com/mrettig/DHBW_LaTeX_Vorlage.git
cd DHBW_LaTeX_Vorlage

# Open in your editor
code .                    # VS Code
texmaker DHBW*.pro       # Texmaker
```

### 2. Configure Document

Edit `config/config.tex`:

```latex
\newcommand{\thesisTitle}{Your Title Here}
\newcommand{\author}{Your Name}
\newcommand{\matrikelNumber}{1234567}
\newcommand{\student}{Your Name}
\newcommand{\courseName}{DH12345}
\newcommand{\courseYear}{2024}
% ... more options
```

### 3. Write Content

Edit chapters in `text/`:

- `01-chapter.tex` through `04-chapter.tex` - main content
- `apendix.tex` - appendices
- `acronym.tex` - abbreviations

Example chapter structure:

```latex
% text/01-chapter.tex
\section{Chapter 1: Introduction}

\subsection{Motivation}
Your content here...

\begin{figure}[h]
  \centering
  \includegraphics[width=0.8\textwidth]{path/to/image.png}
  \caption{Figure caption}
  \label{fig:example}
\end{figure}

Reference: See Figure \ref{fig:example}
\cite{Smith2020}
```

### 4. Build & Review

```bash
# VS Code: Ctrl+Alt+B to build
# Or terminal:
make all

# View PDF - auto-opens in VS Code PDF viewer
```

### 5. Git Workflow

```bash
# Check status
git status

# Stage changes
git add text/01-chapter.tex config/config.tex

# Commit
git commit -m "Add introduction section"

# Push to GitHub
git push origin main

# → Automatic build & artifact creation on GitHub!
```

---

## Building

### Watch Mode (Auto-rebuild)

Rebuild PDF every time you save:

```bash
make watch
# Or directly:
latexmk -xelatex -biber -pdf -pvc main.tex
```

Press `q` to stop.

### Clean Build

Remove all artifacts and rebuild fresh:

```bash
make distclean
make all

# Or single command:
make clean && make all
```

### Docker Build (No Local LaTeX)

```bash
docker build -t dhbw-latex .
docker run --rm -v $(pwd):/work dhbw-latex
```

### GitHub Actions (Automatic)

```bash
git push origin main
# → PDF builds automatically
# → Download from Actions tab
```

---

## Bibliography Management

### Add References to bibliography.bib

File: `assets/literature/bibliography.bib`

**Book:**
```bibtex
@book{Smith2020,
  author    = {John Smith},
  title     = {Great Research},
  year      = {2020},
  publisher = {Academic Press},
  isbn      = {978-3-123456-78-9}
}
```

**Journal Article:**
```bibtex
@article{Johnson2021,
  author  = {Jane Johnson and Bob Lee},
  title   = {Important Discovery},
  journal = {Nature Research},
  year    = {2021},
  volume  = {42},
  number  = {3},
  pages   = {123--145}
}
```

**Website:**
```bibtex
@online{Mozilla2023,
  author  = {Mozilla Developer Network},
  title   = {Web Standards},
  url     = {https://developer.mozilla.org},
  year    = {2023},
  urldate = {2023-12-01}
}
```

### Cite in Text

```latex
% Author-year format
\textcite{Smith2020} shows that...

% Parenthetical
According to research \cite{Smith2020, Johnson2021}...

% Multiple authors
As \textcite*{Smith2020} discovered...
```

### Validate Bibliography

```bash
# Check for undefined citations
grep -oP '\\(?:cite|textcite)\{[^}]*\}' **/*.tex | \
  sed 's/.*{\|}.*//' | sort -u > cited.txt

# Check .bib entries
grep '@' assets/literature/bibliography.bib | \
  sed 's/@.*{\|,.*//' | sort -u > defined.txt

# Compare
diff cited.txt defined.txt
```

---

## Code Highlighting

### Using Minted

Insert code blocks with syntax highlighting:

```latex
\begin{minted}{python}
def hello(name):
    print(f"Hello, {name}!")
\end{minted}
```

**Supported languages:**
- python, java, cpp, javascript, latex, bash, sql, html, css, ...

**Customize:**
```latex
\begin{minted}[
  linenos=true,
  fontsize=\small,
  bgcolor=lightgray
]{python}
print("Hello")
\end{minted}
```

### From External File

```latex
% Include entire file
\inputminted{python}{scripts/example.py}

% Include lines 10-20
\inputminted[firstline=10, lastline=20]{python}{scripts/example.py}
```

### Styling

```latex
% In preamble.tex
\usemintedstyle{monokai}    % Color scheme
\setmintedstyle{emacs}      % Alternative
```

---

## Performance Optimization

### Measure Build Time

```bash
# Time your build
time latexmk -xelatex -biber -pdf main.tex

# Typical: 40-90 seconds for 100+ page document
```

### Bottleneck Analysis

```bash
# Verbose output shows where time is spent
latexmk -xelatex -biber -pdf -verbose main.tex
```

### Optimization Tips

1. **Use tikz sparingly** - Complex diagrams slow builds
2. **Optimize images** - Large images increase compile time
3. **Use references smartly** - Complex cross-references add overhead
4. **Cache biber results** - Don't reprocess bibliography every build
5. **Limit number of included PDFs** - pdfpages is slow

### Make Builds Faster

```latex
% In preamble.tex - comment out slow features temporarily

% During development only:
% \usepackage{minted}         % Slower
% \usepackage{tikz}           % Slower

% Keep minimal packages active
```

---

## Tips & Tricks

### Snippet: Algorithm

```latex
\begin{algorithm}[H]
  \caption{Algorithm Name}
  \begin{algorithmic}
    \STATE Initial variable
    \FOR{each item}
      \IF{condition}
        \STATE do something
      \ENDIF
    \ENDFOR
  \end{algorithmic}
\end{algorithm}
```

### Snippet: Colored Table Row

```latex
\rowcolor{lightgray}Column 1 & Column 2 & Column 3\\
```

### Snippet: Two-Column Text

```latex
\begin{multicols}{2}
  Left column text here...
  \columnbreak
  Right column text here...
\end{multicols}
```

### Snippet: Centered Figure

```latex
\begin{figure}[h]
  \centering
  \includegraphics[width=0.6\textwidth]{image.pdf}
  \caption{Caption here}
  \label{fig:unique-label}
\end{figure}
```

### Quick Acronym

Add to `text/acronym.tex`:

```latex
\DeclareAcronym{api}{
  short = API,
  long = Application Programming Interface
}
```

Use in text:

```latex
\ac{api}      % First use: "API (Application Programming Interface)"
\ac{api}      % Later: "API"
\acl{api}     % Always long form
\acs{api}     % Always short form
```

### Math Mode

Inline math: `$y = mx + b$`

Display math:
```latex
\begin{equation}
  y = mx + b
  \label{eq:linear}
\end{equation}

Reference: Equation \ref{eq:linear}
```

### Internal Cross-References

```latex
\label{sec:introduction}    % In section
\label{fig:diagram}         % On figures
\label{tab:data}            % On tables

\ref{sec:introduction}      % Number only
\nameref{sec:introduction}  % Section name
\full ref{sec:introduction} % "Section 1: Introduction"
```

### Margin Notes

```latex
\marginpar{Note in margin}
```

### Draft Mode (Hide Figures)

```latex
% In preamble
\documentclass[draft]{article}

% Figures show as boxes (faster builds)
```

---

## Common Issues

### ❌ Reference undefined

```
LaTeX Warning: Reference ... undefined
```

**Fix:** Add `\label` to target:
```latex
\section{Title}
\label{sec:title}     % Add this

...

See Section \ref{sec:title}
```

### ❌ Bibliography not appearing

```
No bibliography produced by Biber
```

**Fix:** Ensure biber runs:
```bash
latexmk -xelatex -biber -pdf main.tex
# -biber flag is important!
```

### ❌ Minted colors not working

```
Package minted Error: Lexer lexer not found
```

**Fix:** Ensure Pygments is installed:
```bash
pip install pygments
# Or: apt-get install python3-pygments (Linux)
```

### ❌ Font not found

```
Font "Arial" was not found
```

**Fix:** Use available fonts or comment:
```latex
% \setmainfont{Arial}  % Not available
\setmainfont{TeX Gyre Termes}  % Use instead
```

---

## Resources

- [LaTeX Wikibook](https://en.wikibooks.org/wiki/LaTeX)
- [Overleaf Tutorials](https://www.overleaf.com/learn)
- [TikZ Manual](https://ctan.org/pkg/pgf)
- [BibTeX Styles](http://www.ctan.org/pkg/biblatex)

---

**Next Steps:**
- Follow [Quick Start](README.md#quick-start)
- Configure `config/config.tex`
- Start writing in `text/01-chapter.tex`
- Check [DOCKER.md](DOCKER.md) for advanced builds
