# Paper Template with GitHub Actions compilation
## Description

This repository contains a paper submission for ....

### 📄 Paper Build Status

The paper is automatically built and released on every push to the main branch. The latest PDF is available in the [Releases](../../releases) section.

### 🛠️ Building the Paper

The paper uses LaTeX with the ACM template. The build process has been streamlined for both local and CI/CD environments.

#### Prerequisites

- **LaTeX Distribution**: TeX Live 2024+ or equivalent
- **Build Tool**: latexmk (usually included with TeX Live)
- **Required Packages**: ACM template files are included in the repository

#### Local Build

The simplest way to build the paper locally:

```bash
# Build the paper (output: _build/<folder-name>.pdf)
latexmk

# Clean build artifacts
latexmk -c

# Force rebuild from scratch
latexmk -g
```

The build system is configured via `.latexmkrc` to:
- Use `paper.tex` as the main source file
- Output PDF named after the current folder (e.g., `_build/eaai-2026-dreamweaving.pdf`)
- Automatically handle bibliography compilation
- Find all necessary template files in the `templates/` directory
- **No configuration needed** - the PDF name is derived from the folder name

#### Switching Between Anonymous and Camera-Ready Versions

The paper can be built in two modes:

1. **Anonymous submission** (default): Anonymizes author information and affiliations
2. **Camera-ready version**: Includes full author details

To switch between modes, edit `paper-config.tex`:

```latex
% For anonymous submission (default):
\anonymoustrue

% For camera-ready version:
\anonymousfalse
```

Then rebuild with `latexmk`.

#### Continuous Integration

Every push to the repository triggers an automated build via GitHub Actions that:
1. 📥 Checks out the repository
2. 📦 Installs LaTeX dependencies on Ubuntu 22.04
3. 🔨 Builds the paper with latexmk
4. 📝 Creates a timestamped PDF named after the repository
5. 📤 Uploads the PDF as a build artifact
6. 🚀 Creates a GitHub release with the compiled PDF

### 📁 Repository Structure

```
.
├── paper.tex                 # Main LaTeX source file
├── paper-config.tex         # Configuration for anonymous/camera-ready mode
├── .latexmkrc               # Build configuration
├── templates/               # Conference templates
│   ├── aaai/               # AAAI 2026 template files
│   │   ├── aaai2026.sty
│   │   └── aaai2026.bst
│   └── acm/                # ACM template files (preserved for reference)
├── bib/                     # Bibliography files
│   └── scifi-creative-writing.bib
├── _build/                  # Build output directory (git-ignored)
└── .github/
    └── workflows/
        └── build-paper.yml  # GitHub Actions CI/CD configuration
```

### 🔧 Editor-specific Setup

- **VS Code**: Open this folder in VS Code with the LaTeX Workshop extension installed
- **TeXStudio**: Go to Options → Load Profile and select `texstudio.txsprofile`
- **Overleaf**: Upload all files including `.latexmkrc` and `paper-config.tex`
- **Other Editors**: Any editor that uses latexmk or respects `.latexmkrc` will work with this setup

### 🐛 Troubleshooting

If you encounter build issues:

1. **Missing citations**: The bibliography file is in `bib/scifi-creative-writing.bib`. Two citations (`Jasanoff2003`, `VakkuriJohnson2020`) are currently undefined and need to be added.

2. **Clean build**: If you see strange errors, try cleaning first:
   ```bash
   latexmk -c
   latexmk
   ```

3. **Manual build**: If latexmk fails, you can build manually:
   ```bash
   pdflatex -output-directory=_build -jobname=eaai-2026-dreamweaving paper.tex
   cd _build && bibtex eaai-2026-dreamweaving && cd ..
   pdflatex -output-directory=_build -jobname=eaai-2026-dreamweaving paper.tex
   pdflatex -output-directory=_build -jobname=eaai-2026-dreamweaving paper.tex
   ```

### 📝 Paper Status

**Current TODOs:**
- [ ] Complete abstract (75-150 words)
- [ ] Write introduction opening paragraph
- [ ] Add course description and learning objectives
- [ ] Include assignment specification in Appendix A
- [ ] Include example vignettes in Appendix B
- [ ] Include grading rubric in Appendix C
- [ ] Add missing bibliography entries (Jasanoff2003, VakkuriJohnson2020)
- [ ] Write acknowledgments section
- [ ] Update author information before submission

### 📚 Contributing

When making changes:
1. Edit `paper.tex` or bibliography files
2. To switch between anonymous/camera-ready: edit `paper-config.tex`
3. Run `latexmk` to build locally
4. Commit and push - GitHub Actions will automatically build and release

### 🎯 Submission Information

- **Conference**: EAAI 2026 (Educational Advances in Artificial Intelligence)
- **Part of**: AAAI 2026
- **Submission Mode**: Currently configured for anonymous submission
- **Template**: AAAI 2026 official LaTeX template

### 📄 License

This work is intended for academic submission. Copyright and licensing will be determined upon publication.