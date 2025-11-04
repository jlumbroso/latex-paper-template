# Academic Paper Template with Auto-Compilation

A clean, beginner-friendly LaTeX template for writing academic papers with automatic GitHub Actions compilation, built-in anonymization support, and helpful workflow tools.

## Quick Start

1. **Clone this template** and open it in your favorite LaTeX editor
2. **Edit `paper.tex`** - Replace the fixture content with your paper
3. **Edit `bib/references.bib`** - Add your bibliography entries
4. **Build locally**: Run `latexmk` in the terminal
5. **Push to GitHub**: Automatic builds create PDFs in the [Releases](../../releases) section

That's it! The template is pre-configured to work out of the box.

---

## Features

- **Works Out of the Box**: Pre-configured ACM template with fixture content showing typical paper structure
- **Easy Anonymization**: Simple toggle between anonymous submission and camera-ready versions
- **Auto-Compilation**: GitHub Actions automatically builds and releases PDFs on every push
- **Beginner-Friendly**: Extensive comments and examples throughout
- **TODO Workflow**: Built-in support for drafting notes and comments
- **Modern Build System**: Uses `latexmk` with smart dependency tracking

---

## Building the Paper

### Prerequisites

- **LaTeX Distribution**: TeX Live 2024+ (or MiKTeX/MacTeX)
- **Build Tool**: latexmk (included with most distributions)

### Local Build Commands

```bash
# Build the paper
latexmk

# Clean build artifacts
latexmk -c

# Force complete rebuild
latexmk -g
```

The PDF will be in `_build/<folder-name>.pdf` (automatically named after your repository folder).

### How It Works

The `.latexmkrc` file configures everything automatically:
- Main source: `paper.tex`
- Output: `_build/<folder-name>.pdf`
- Bibliography: Automatically compiled from `bib/references.bib`
- Templates: Found in `templates/acm/`
- **No manual configuration needed!**

---

## Switching Between Anonymous and Camera-Ready Versions

Many conferences require **anonymous submissions** for peer review, then a **camera-ready version** with author information after acceptance.

This template makes switching between modes effortless.

### How to Switch

Edit `paper-config.tex`:

```latex
% For anonymous submission (default):
\anonymoustrue

% For camera-ready version:
\anonymousfalse
```

Then rebuild with `latexmk`. That's it!

### What Gets Anonymized

- **Author information**: Shows "Anonymous Submission" instead of real names
- **Acknowledgments**: Completely suppressed in anonymous mode
- **Custom macros**: Any text you've marked with anonymization helpers (see below)

### Anonymization Helpers

The template provides two ways to anonymize content:

#### Option 1: Inline Helper (Quick & Easy)

Use `\anontext{anonymous version}{named version}` anywhere in your paper:

```latex
This work was conducted at \anontext{[Institution Anonymized]}{Stanford University}.
```

#### Option 2: Custom Macros (For Repeated Terms)

Define macros once at the top of `paper.tex`, use them throughout your paper. The template includes examples:

```latex
% In preamble:
\ifanonymous
    \newcommand{\OurInstitution}{[Institution Anonymized]}
    \newcommand{\OurLab}{[Lab Name Anonymized]}
\else
    \newcommand{\OurInstitution}{Stanford University}
    \newcommand{\OurLab}{AI Research Lab}
\fi

% In paper body:
We conducted experiments at \OurInstitution{} in collaboration with \OurLab{}.
```

**Tip**: Use custom macros for terms that appear multiple times. Use `\anontext` for one-off mentions.

---

## TODO Notes and Drafting Workflow

The template includes `todonotes` package for managing your writing process.

### Basic TODO Commands

```latex
% Margin note (appears as a colored box in margin)
\todo{Expand this section with more examples}

% Inline note (appears in the text flow)
\todo[inline]{Need to add experimental results here}

% Color-coded priorities
\todo[color=red]{CRITICAL: Add citation for this claim}
\todo[color=yellow]{Consider adding a figure here}
\todo[color=blue]{Optional: Discuss limitations}
```

### Recommended TODO Categories

**1. Content TODOs** (what to write):
```latex
\todo{Add related work comparison}
\todo[inline]{Write evaluation section}
```

**2. Technical TODOs** (what to fix/improve):
```latex
\todo{Cite source for this data}
\todo{Verify these numbers}
```

**3. Revision TODOs** (what to polish):
```latex
\todo{Rewrite for clarity}
\todo{Shorten this paragraph}
```

**4. Submission TODOs** (pre-submission checklist):
```latex
\todo[color=red]{Remove all TODOs before submission!}
\todo[color=red]{Switch to camera-ready mode}
```

### Hiding TODOs for Submission

Before submission, either:
- Remove `\usepackage{todonotes}` from `paper.tex`, OR
- Change it to `\usepackage[disable]{todonotes}` (keeps commands but hides output)

---

## Repository Structure

```
.
├── paper.tex                 # Main LaTeX source file (edit this!)
├── paper-config.tex         # Anonymous/camera-ready toggle
├── bib/
│   └── references.bib       # Your bibliography entries
├── figures/                 # Put your images here
├── templates/
│   └── acm/                 # ACM template files (pre-included)
├── _build/                  # Build outputs (git-ignored)
├── .latexmkrc               # Build configuration
└── .github/workflows/
    └── build-paper.yml      # GitHub Actions auto-build
```

---

## Continuous Integration (GitHub Actions)

Every push to the repository triggers an automated build that:

1. 📥 Installs LaTeX on Ubuntu
2. 🔨 Compiles the paper with `latexmk`
3. 📤 Uploads the PDF as a build artifact
4. 🚀 Creates a GitHub Release with:
   - Timestamped PDF (e.g., `my-paper-2024-01-15-10-30.pdf`)
   - Commit history since last release
   - Build metadata

**Access PDFs**: Go to your repo → [Releases](../../releases) → Download the latest PDF

**View build logs**: Go to your repo → Actions tab

---

## Customizing for Your Conference

The template uses **ACM format** by default, but you can switch to any conference template.

### Changing the Template

1. **Add template files** to `templates/<conference-name>/`
2. **Update `paper.tex` line 12**:
   ```latex
   \documentclass[...]{acmart}  % Change this to your conference class
   ```
3. **Update `.latexmkrc` lines 17-19** to include your template directory
4. **Adjust packages** in `paper.tex` as needed for your conference

Common templates: ACM, IEEE, AAAI, NeurIPS, CVPR, etc.

---

## Editor-Specific Setup

### VS Code
- Install **LaTeX Workshop** extension
- Open this folder in VS Code
- Build with `Ctrl+Alt+B` (or `Cmd+Option+B` on Mac)

### TeXStudio
- Open → Load Profile → `texstudio.txsprofile`

### Overleaf
- Upload all files including `.latexmkrc` and `paper-config.tex`
- Set main document to `paper.tex`

### Other Editors
Any editor that respects `.latexmkrc` will work automatically!

---

## Troubleshooting

### "Undefined citations" or "Undefined references"

This is normal on the first build. LaTeX needs multiple passes:

```bash
latexmk -c    # Clean
latexmk       # Rebuild
```

Or run `latexmk` a second time. It will automatically handle all passes.

### "File not found" errors for bibliography

Make sure your bibliography file is in `bib/references.bib` and uncommented in `paper.tex`:

```latex
\bibliography{references}  % Should NOT have .bib extension
```

### Build fails on GitHub Actions

Check the Actions tab for error logs. Common issues:
- Missing packages (add them to `build-paper.yml`)
- Template incompatibility (test locally first)

### Manual build (if latexmk fails)

```bash
pdflatex -output-directory=_build -jobname=<folder-name> paper.tex
cd _build && bibtex <folder-name> && cd ..
pdflatex -output-directory=_build -jobname=<folder-name> paper.tex
pdflatex -output-directory=_build -jobname=<folder-name> paper.tex
```

---

## Recommended Packages

The template includes commonly-used packages. Here are some additional recommendations:

### For Algorithms

Already included: `algorithm`, `algorithmic`

Alternative: `algorithm2e` (more flexible but different syntax)

### For Tables

Already included: `booktabs` (professional-looking tables)

Recommended: `multirow`, `longtable` (for complex tables)

### For Math

Already included: `amssymb`, `amsmath` (via ACM template)

Recommended: `amsthm` (for theorems), `mathtools` (enhanced math)

### For Figures

Already included: `graphicx`, `subfig`, `float`

Recommended: `tikz` (for diagrams), `pgfplots` (for plots)

### For Code Listings

Recommended: `listings` or `minted` (syntax highlighting)

### For Anonymization

Already built-in! See "Switching Between Anonymous and Camera-Ready Versions" above.

Alternative packages: `anonymous`, `authorblind` (but manual approach is more flexible)

### For Comments and Collaboration

Already included: `todonotes`, `comment`

Alternative: `changes` (track changes like Word), `pdfcomment` (PDF annotations)

---

## Contributing

This template is designed to be customized for your needs! Feel free to:

- Modify the fixture content in `paper.tex`
- Adjust packages and settings for your conference
- Customize the GitHub Actions workflow
- Add your own helper macros

---

## License

This template is provided as-is for academic use. The ACM template files in `templates/acm/` are subject to ACM's licensing terms. Your paper content and modifications are yours to license as you see fit.

---

## Tips for Writing a Great Paper

1. **Start with the structure**: Use the fixture sections as a guide, adjust as needed
2. **Write the abstract last**: Once you know what you've written
3. **Use TODOs liberally**: Mark areas that need work, prioritize with colors
4. **Commit often**: Small commits make it easy to track changes and revert if needed
5. **Build frequently**: Catch LaTeX errors early while you remember the context
6. **Use anonymization**: Even if not required initially - good practice for sharing drafts
7. **Get feedback early**: Share PDFs from GitHub Releases with collaborators

Good luck with your paper! 🎓
