# Salmon Escapement Data Guidebook (bookdown)

This repo scaffolds a `bookdown` guidebook for DFO Pacific Region Areas to
process multi-source escapement data into Conservation Unit (CU) time series
that interoperate for Wild Salmon Policy (WSP) and Fisheries Act reporting.

## Prerequisites

- R (4.0+ recommended)
- Pandoc (bundled with RStudio or install separately)
- R packages: `bookdown` (plus your analysis stack as needed)

Install core deps:

```r
install.packages("bookdown")
```

## Project structure

- `_bookdown.yml` — book metadata and chapter ordering (outputs to `docs/` for Pages).
- `_output.yml` — output formats (gitbook, PDF, EPUB) and basic config.
- `index.Rmd` — preface/front-matter.
- `scripts/` — helper scripts used by cookbook workflows (for example, SPSR package pre-flight validation).
- `01-*.Rmd` — numbered cookbook chapters. Current structure:
  - `01-introduction.Rmd`
  - `02-getting-started.Rmd`
  - `03-source-data-verification.Rmd`
  - `04-site-survey-selection.Rmd`
  - `05-record-selection.Rmd`
  - `06-record-processing.Rmd`
  - `07-estimation.Rmd`
  - `08-metadata-and-metric-specs.Rmd`
  - `09-patterns-and-templates.Rmd`
  - `10-worked-examples.Rmd`
  - `11-checklists-and-decision-trees.Rmd`
  - `12-appendix.Rmd`
- `style.css` — minimal theme overrides for the gitbook build.
- `docs/` — rendered site for GitHub Pages (keep committed), with `.nojekyll`.

## Common commands

Render HTML gitbook (default):

```r
bookdown::render_book("index.Rmd", "bookdown::gitbook")  # writes to docs/
```

Render PDF (requires LaTeX toolchain):

```r
bookdown::render_book("index.Rmd", "bookdown::pdf_book")
```

Render EPUB:

```r
bookdown::render_book("index.Rmd", "bookdown::epub_book")
```

Preview a single chapter while writing:

```r
bookdown::preview_chapter("01-introduction.Rmd")
```

Clean build artifacts:

```r
bookdown::clean_book()
```

## Publish to GitHub Pages

1) Build: `bookdown::render_book("index.Rmd", "bookdown::gitbook")` (creates/updates `docs/`).  
2) Ensure `docs/.nojekyll` stays committed.  
3) Push to GitHub and set Pages source to `main` / `docs` in repo settings.  
Reference: <https://bookdown.org/yihui/bookdown/github.html>.
