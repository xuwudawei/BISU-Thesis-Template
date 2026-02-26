# BISU Thesis Template — 2026 Edition (北京第二外国语学院毕业论文模板)

A LaTeX template for writing a master's thesis at **Beijing International Studies University (BISU), School of Business**. Updated to comply with the **2026 thesis formatting requirements**.

## 2026 Formatting Requirements

This template follows the official BISU School of Business 2026 guidelines:

| Requirement | Setting |
|-------------|---------|
| Font | Times New Roman throughout |
| Body text size | 12pt |
| Chapter heading size | 14pt, ALL CAPS |
| Caption size | 10-11pt |
| Line spacing | 1.5 |
| Margins | 1 inch on all sides |
| Text alignment | Justified |
| Page numbers (front matter) | Roman numerals (i, ii, iii...), bottom center |
| Page numbers (main text) | Arabic numerals (1, 2, 3...), bottom center |
| Tables | "Three-line" style (booktabs) |
| Citations | APA style: (Author, Year) |

## Prerequisites

You need a LaTeX distribution with **XeLaTeX** support:

- **Windows**: [TeX Live](https://www.tug.org/texlive/) (full installation recommended)
- **macOS**: [MacTeX](https://www.tug.org/mactex/)
- **Linux**: `sudo apt install texlive-full` (Ubuntu/Debian) or `sudo dnf install texlive-scheme-full` (Fedora)

## Quick Start

1. **Clone this repository**
   ```bash
   git clone https://github.com/xuwudawei/BISU-Thesis-Template.git
   cd BISU-Thesis-Template
   ```

2. **Edit your thesis information** in `bisusetup.tex`:
   - Title (Chinese and English)
   - Author name
   - Supervisor name
   - Degree type (Master of Management)
   - Program (IMBA / IMiM / IMPAcc)
   - Date

3. **Write your thesis** in the `data/` folder:

   | File | Content |
   |------|---------|
   | `data/originality.tex` | Statement of Originality (原创性声明) |
   | `data/authorization.tex` | Authorization of Use (使用授权说明) |
   | `data/confidentiality.tex` | Statement of Confidentiality (密级声明) |
   | `data/acknowledgements.tex` | Acknowledgements |
   | `data/abstract.tex` | Abstract (English + Chinese) with keywords |
   | `data/chap01.tex` | Chapter 1: INTRODUCTION |
   | `data/chap02.tex` | Chapter 2: LITERATURE REVIEW |
   | `data/chap03.tex` | Chapter 3: THEORETICAL FRAMEWORK |
   | `data/chap04.tex` | Chapter 4: RESEARCH METHODOLOGY |
   | `data/chap05.tex` | Chapter 5: RESULTS AND DISCUSSION |
   | `data/chap06.tex` | Chapter 6: CONCLUSIONS |
   | `data/appendix.tex` | Appendices (APPENDIX A, APPENDIX B, etc.) |
   | `data/resume.tex` | Author's Curriculum Vitae |
   | `data/supervisor-evaluation.tex` | Supervisor's Evaluation |

4. **Add references** to `ref/refs.bib` in BibTeX format (see examples inside).

5. **Add figures** to the `figures/` folder.

6. **Add your front cover** as `frontcover_without_supervisor_name.pdf` in the root directory.

## Compiling the Thesis

**You MUST compile with XeLaTeX** (not pdfLaTeX).

### Command Line

```bash
xelatex bisuthesis-example.tex
bibtex bisuthesis-example
xelatex bisuthesis-example.tex
xelatex bisuthesis-example.tex
```

### Using latexmk (Recommended)

```bash
latexmk -xelatex bisuthesis-example.tex
```

### Using Overleaf

1. Upload all files to a new Overleaf project.
2. Go to **Menu** > set compiler to **XeLaTeX**.
3. Click **Recompile**.

### Using VS Code

1. Install the [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) extension.
2. Add this to your VS Code `settings.json`:
   ```json
   {
     "latex-workshop.latex.tools": [
       {
         "name": "xelatex",
         "command": "xelatex",
         "args": ["-synctex=1", "-interaction=nonstopmode", "%DOC%"]
       },
       {
         "name": "bibtex",
         "command": "bibtex",
         "args": ["%DOCFILE%"]
       }
     ],
     "latex-workshop.latex.recipes": [
       {
         "name": "xelatex -> bibtex -> xelatex x2",
         "tools": ["xelatex", "bibtex", "xelatex", "xelatex"]
       }
     ]
   }
   ```
3. Build with `Ctrl+Alt+B` (or `Cmd+Option+B` on macOS).

## Document Structure (2026)

The thesis follows this order as required by BISU:

```
Cover Page
├── STATEMENT OF ORIGINALITY
├── AUTHORIZATION OF USE
├── STATEMENT OF CONFIDENTIALITY
├── ACKNOWLEDGEMENTS
├── ABSTRACT (English)
├── 中文摘要 (Chinese Abstract)
├── TABLE OF CONTENTS
├── LIST OF FIGURES
├── LIST OF TABLES
├── [LIST OF ABBREVIATIONS] (optional)
│
├── CHAPTER 1  INTRODUCTION
├── CHAPTER 2  LITERATURE REVIEW
├── CHAPTER 3  THEORETICAL FRAMEWORK
├── CHAPTER 4  RESEARCH METHODOLOGY
├── CHAPTER 5  RESULTS AND DISCUSSION
├── CHAPTER 6  CONCLUSIONS
│
├── REFERENCES
├── APPENDIX A. [TITLE]
├── APPENDIX B. [TITLE]
├── AUTHOR'S CURRICULUM VITAE
└── SUPERVISOR'S EVALUATION OF THESIS
```

## Citation Format

Use APA-style parenthetical citations:

| Authors | In-text citation | LaTeX command |
|---------|-----------------|---------------|
| Single author | (Adams, 2006) | `\citep{adams2006}` |
| Two authors | (Adams & Brown, 2006) | `\citep{adams2006}` |
| Three+ authors | (Adams et al., 2006) | `\citep{adams2006}` |

Example references in all four formats (journals, books, reports, dissertations) are included in `ref/refs.bib`.

## Tables: "Three-Line" Style

BISU 2026 requires "three-line" tables. Use `booktabs` commands:

```latex
\begin{table}[htbp]
  \centering
  \caption{Your table caption}
  \begin{tabular}{lcc}
    \toprule           % top border
    Variable & Mean & SD \\
    \midrule           % header border
    Item 1   & 3.45 & 0.82 \\
    Item 2   & 4.12 & 0.65 \\
    \bottomrule        % bottom border
  \end{tabular}
\end{table}
```

No vertical borders. No borders around every cell.

## Configuration Options

In `bisuthesis-example.tex`:

| Option | Values | Description |
|--------|--------|-------------|
| `degree` | `doctor`, `master`, `bachelor` | Degree level |
| `language` | `chinese`, `english` | Thesis language |
| `fontset` | `windows`, `mac`, `fandol`, `ubuntu` | Font set (match your OS) |

In `bisusetup.tex`: title, author, supervisor, degree, program, department, date.

## Tips

- **Font issues?** Set `fontset` to match your OS. Use `windows` for final submission.
- **Front cover**: Create your own cover page PDF. If you don't have one yet, comment out `\includepdf` in `bisuthesis-example.tex` and uncomment `\maketitle`.
- **Paragraphs**: May be indented or un-indented, but be consistent throughout. If un-indented, add extra space between paragraphs.

## Acknowledgements and Attribution

This template is a **derivative work** based on:

- **[ThuThesis](https://github.com/tuna/thuthesis)** — Tsinghua University Thesis LaTeX Template, Copyright (C) 2005-2021 Tsinghua University TUNA Association, licensed under [LPPL v1.3c](https://www.latex-project.org/lppl.txt)
- **[gbt7714-bibtex-style](https://github.com/CTeX-org/gbt7714-bibtex-style)** — GB/T 7714 BibTeX Styles, Copyright (C) 2016-2021 Zeping Lee, licensed under LPPL v1.3c

**This project is NOT affiliated with, endorsed by, or associated with Tsinghua University or the TUNA Association.**

## License

Distributed under the [LaTeX Project Public License (LPPL) v1.3c](https://www.latex-project.org/lppl.txt). See [LICENSE](LICENSE) for details.

## Contributing

If you find issues or have improvements, feel free to open an issue or submit a pull request.
