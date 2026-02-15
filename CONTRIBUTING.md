# Contributing Guide - DHBW LaTeX Template

How to improve the DHBW LaTeX template and contribute back to the community.

**Table of Contents:**
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Process](#development-process)
- [Guidelines](#guidelines)
- [Submitting Changes](#submitting-changes)
- [Maintators](#maintators)

---

## Code of Conduct

Please be respectful and constructive when contributing.

**We welcome:**
- Bug reports with reproducible examples
- Feature requests with clear use cases
- Improvements to documentation
- Performance optimizations
- Platform-specific fixes

**We discourage:**
- Major breaking changes without discussion
- Adding unnecessary packages
- Complicating the minimal design philosophy

---

## Getting Started

### 1. Fork the Repository

```bash
# Visit GitHub and click "Fork"
# Clone your fork
git clone https://github.com/YOUR-USERNAME/DHBW_LaTeX_Vorlage.git
cd DHBW_LaTeX_Vorlage

# Add upstream reference
git remote add upstream https://github.com/mrettig/DHBW_LaTeX_Vorlage.git
```

### 2. Create Feature Branch

```bash
# Update from upstream
git fetch upstream
git checkout -b improve/my-feature

# Make your changes
# Commit with clear messages
git commit -m "Add feature: description"

# Push to your fork
git push origin improve/my-feature
```

### 3. Submit Pull Request

On GitHub:
1. Click "New Pull Request"
2. Select your feature branch
3. Write description (see template below)
4. Submit

---

## Development Process

### Workflow

```
1. Identify issue/improvement
2. Fork & create feature branch
3. Make focused changes
4. Test thoroughly
5. Document changes
6. Submit PR
7. Address review feedback
8. Merge & celebrate! 🎉
```

### Testing Your Changes

#### Local Build

```bash
# Ensure PDF builds without errors/warnings
make distclean
make all

# Check for LaTeX warnings
grep -i "warning" main.log

# Verify no undefined references
grep "undefined" main.log
```

#### Docker Build

```bash
# Test with Docker (ensures reproducibility)
docker build -t dhbw-latex .
docker run --rm -v $(pwd):/work dhbw-latex
```

#### GitHub Actions

```bash
# After pushing PR, check Actions tab
# Ensure build.yml workflow passes
```

---

## Guidelines

### Package Additions

**Before adding a package:**

1. ✅ Check if alternative exists (avoid duplicates)
2. ✅ Verify it's not included in TeX Live already
3. ✅ Test that it doesn't conflict with existing packages
4. ✅ Ensure compilation time doesn't increase significantly
5. ✅ Document in comments why the package is needed

**When adding:**

```latex
% In config/preamble.tex, add comment explaining:
\usepackage{newpackage}  % For X functionality, required for [reason]
```

**Update Dockerfile if needed:**

```dockerfile
# In Dockerfile, add:
RUN tlmgr install newpackage
```

### LaTeX Code Style

**Good:**
```latex
% Clear, descriptive command names
\newcommand{\myTheoryTitle}[1]{{\Large \textbf{#1}}}

% Document complexity
\renewcommand*{\labelalphaothers}{}  % Suppress "et al" in alpha style

% Explanation for why this is needed
```

**Bad:**
```latex
% Cryptic names
\newcommand{\mt}[1]{{\Large \textbf{#1}}}

% No explanation
\renewcommand*{\labelalphaothers}{}
```

### Documentation

Add inline comments for:
- ✅ Why a package is included
- ✅ Non-obvious configuration options
- ✅ Known limitations or issues
- ✅ References to external documentation

### Commits

**Good commit messages:**

```
Add minted integration for code highlighting

- Install minted package and configure Pygments support
- Add example code blocks in 01-chapter.tex
- Test with Python and LaTeX syntax highlighting
- Docs updated in DEVELOPMENT.md

Fixes #123
```

**Avoid:**
```
fixed stuff
Updated code
asdfjkl
```

### File Organization

Respect the structure:

```
config/       → Document configuration & packages
text/         → Content (chapters, appendix)
assets/       → Media files, bibliography
.github/      → GitHub Actions workflows
.devcontainer/ → VS Code Dev Container
.vscode/      → VS Code settings
```

**Don't:**
- Add random files to root
- Duplicate file structures
- Store compiled PDFs in repo

### Performance

Minimize impact on build time:

- ✅ Use existing packages instead of new ones
- ✅ Optimize image sizes before committing
- ✅ Profile build time: `time latexmk ...`
- ✅ Remove test files before PR

---

## Submitting Changes

### PR Description Template

```markdown
## Description
Brief explanation of what this PR does.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation
- [ ] Performance improvement
- [ ] Refactoring

## Testing
How to test these changes:
1. Step one
2. Step two
3. Verify result

## Screenshots (if applicable)
Before/after comparison

## Checklist
- [ ] Code tested locally
- [ ] Docker build passes
- [ ] GitHub Actions workflow passes
- [ ] Documentation updated
- [ ] No new unnecessary packages added
- [ ] Commit messages are clear
```

### Checking Before Submit

```bash
# 1. Verify build
make distclean && make all

# 2. Check Git status
git status

# 3. Review changes
git diff HEAD~1

# 4. Lint (if available)
chktex main.tex

# 5. Commit & push
git push origin your-branch
```

### Common PR Types

#### Bug Fix

```
Title: Fix [describe bug]

- Identify root cause
- Implement minimal fix
- Add test case
- Verify no side effects
```

#### New Feature

```
Title: Add [feature name]

- Clear use case
- Implementation details
- Documentation examples
- Performance impact analysis
```

#### Documentation

```
Title: Improve/clarify [document name]

- Explain what was confusing
- Provide clearer explanation
- Add examples if helpful
```

---

## Maintainers

Current maintainers:
- **Manuel Rettig** - Original contributor

## Becoming a Maintainer

Active contributors may be invited to maintainers role:
- Consistent, high-quality submissions
- Deep knowledge of LaTeX/template
- Willing to review PRs and guide others

---

## Review Process

**Changes are reviewed for:**

1. ✅ Correctness - Does it work?
2. ✅ Quality - Is it well-written?
3. ✅ Consistency - Does it fit the project?
4. ✅ Performance - Does it slow things down?
5. ✅ Documentation - Is it explained?

**Response time:** 1-2 weeks typically

**Feedback:**
- Be open to suggestions
- Discuss decisions respectfully
- Update code based on feedback
- Ask for clarification if needed

---

## What We're Looking For

### High Priority

- 🟢 Bug fixes with test cases
- 🟢 Documentation improvements
- 🟢 Performance optimizations
- 🟢 Docker/GitHub Actions fixes
- 🟢 Platform compatibility fixes

### Medium Priority

- 🟡 New example chapters
- 🟡 Template variations
- 🟡 VS Code/IDE integrations
- 🟡 CI/CD improvements

### Lower Priority

- 🔴 New packages (require strong justification)
- 🔴 Significant restructuring
- 🔴 Breaking changes

---

## Issue Reporting

Found a bug? Please report it:

1. Check existing issues first
2. Create new issue with title and description
3. Include:
   - LaTeX error message (from main.log)
   - Your system (Windows/Linux/macOS)
   - Build method (Docker/local/Overleaf)
   - Steps to reproduce
4. Attach main.log if build fails

**Good issue:**

```
Title: Bibliography not appearing in PDF

System: M1 MacBook, macOS 13.2
Build method: Docker
LaTeX error: [paste relevant log lines]

Steps to reproduce:
1. Clone repo
2. Add entry to bibliography.bib
3. Cite with \cite{...}
4. Build: make all
5. Bibliography missing from PDF

Expected: Bibliography appears at end
Actual: No bibliography section
```

---

## Recognition

Contributors are recognized in:
- CHANGELOG.md - Listed with contributions
- GitHub - Shown in contributors graph
- README.md - Optional mention for major contributions

---

## Questions?

- 📧 Open an issue
- 💬 Start a discussion on GitHub
- 🐛 Report bugs with examples

---

**Thank you for helping make the DHBW LaTeX template even better!**

Made with ❤️ by the DHBW community
