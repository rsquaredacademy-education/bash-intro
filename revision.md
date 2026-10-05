# Revision Notes

**Date:** 2026-10-05
**Scope:** Structural and build-consistency review (wave 1 — correctness)
**Author:** automated review pass, render-verified with Quarto 1.6.40

Part of a workspace-wide standard for all six books, documented at
`../BOOK-STRUCTURE-CHECKLIST.md`. This file records only what changed in
**this** repository.

---

## Summary

Five classes of fix:

1. Chapter numbering was wrong on every page — corrected and verified.
2. All 13 exercise chapters now link a solution (previously: 12 answer files,
   zero links).
3. A missing answer key was written (`solutions/git-appendix.md`).
4. Five duplicate fixtures untracked from git; one illegal-named stray deleted.
5. A latent working-directory bug fixed in two chapters.

Nothing here changes a URL, a slug, or a redirect.

---

## 1. Chapter numbering (the significant fix)

### The defect

Nine chapter files carried a `title:` key in YAML front matter **in addition to**
their `#` H1. In a Quarto book the YAML `title:` becomes the chapter's number, so
the markdown H1 was counted as a *further* chapter. Every affected page rendered
a heading number one higher than its own sidebar entry.

Confirmed against the live site before changing anything —
`navigating-files-and-directories.html` showed:

- sidebar: `3  Navigating File System`
- page body: `4  Navigating File System`
- in-page TOC: `4.1` … `4.5`

Separately, `index.qmd`'s `title:` consumed chapter slot 1, so the whole book
rendered one chapter ahead of its own README (which claimed Introduction was
chapter 1).

### The fix

- Removed the `title:` line from 9 files. In 6 cases the H1 text was already
  identical, so chapter titles are unchanged; in 2 cases the file had **no** H1
  at all, so one was added.
- Merged `index.qmd`'s duplicate `# Preface {-}` and dropped its
  `title:`/`author:` (both are declared in `_quarto.yml`).

| File | Change |
|:--|:--|
| `cheatsheet.qmd` | `title:` removed; `# Shell ↔ R Cheat Sheet {#sec-cheatsheet}` added — the file previously had **zero** headings |
| `git-appendix.qmd` | `title:` removed; `# Appendix: Git in 10 Minutes for RStudio Users {#sec-git-appendix}` added — also had no H1 |
| `index.qmd` | `title:`/`author:` removed; two H1s merged to one `# Preface {.unnumbered}` |
| `command-line-data-transfer.qmd` | `title:` removed |
| `command-line-file-compression.qmd` | `title:` removed |
| `command-line-file-management.qmd` | `title:` removed |
| `command-line-input-output.qmd` | `title:` removed |
| `command-line-regular-expression.qmd` | `title:` removed |
| `navigating-files-and-directories.qmd` | `title:` removed |

### Result

Sidebar, page heading and in-page TOC now agree, and chapters 1–12 match the
README syllabus table:

| Before (body) | After | Chapter |
|--:|:--|:--|
| 2 | **1** | Introduction |
| 4 | **2** | Navigating File System |
| 5 | **3** | File Management |
| 6 | **4** | Input/Output |
| 7 | **5** | Search & Regular Expression |
| 8 | **6** | Data Transfer |
| 9 | **7** | sudo |
| 10 | **8** | File Compression |
| 11 | **9** | System Info |
| 12 | **10** | R & the Shell |
| 13 | **11** | Pipes & Redirection |
| 14 | **12** | Conclusion |
| 15 | **13** | Shell ↔ R Cheat Sheet |
| 16 | **14** | Appendix: Git in 10 Minutes |

---

## 2. Exercise solutions

### Missing answer key written

`solutions/git-appendix.md` did not exist — `git-appendix.qmd` had three
exercises and no answers. All three answers were **verified by running them**
in a throwaway repository (`git init`, two commits, `.gitignore` behaviour)
rather than written from memory. The verification turned up a detail worth
having in the key: `.gitignore` itself shows as `?? .gitignore` until staged.

### All chapters now linked

The book had 12 solution files and **no chapter pointed at any of them** — the
folder was reachable only from `README.md`. All 13 exercise chapters now carry
the same one-line pointer already used byte-identically by rdbsql and
viz-ggplot2:

```markdown
Worked solutions in `solutions/<slug>.md` (attempt first).
```

Cross-book state after this change: **32 pointers, 0 broken, 0 orphaned.**

> Note: solution filenames do not match chapter slugs 1:1 (e.g.
> `r-command-line.qmd` → `solutions/r-shell.md`). This is pre-existing and is
> tracked as wave 6 work, not fixed here.

---

## 3. Stray artifacts removed

### `img/J?` — deleted

Byte-identical (SHA256) to `img/cline_cover_image.png`, which is tracked and
referenced. Its filename contained **U+F02A**, a private-use Unicode character —
an illegal Windows filename, almost certainly a bad copy-paste of a symbol font
glyph. Removed from git and from disk.

### Five duplicate fixtures — untracked, kept on disk

| File | Why it is a duplicate |
|:--|:--|
| `analysis.R` | Present in `seed/cline-seed.tar.gz`; read from `cline/` |
| `imports_blorr.txt` | same |
| `imports_olsrr.txt` | same |
| `zip_example.zip` | same |
| `release.txt` | Exercise scratch — chapters tell the *reader* to create it |

`cline/` is restored from `seed/cline-seed.tar.gz` by
`scripts/reset-fixture.R`, so these root copies are never read by a build.

They were removed with `git rm --cached`, which **leaves the files on disk**, so
no exercise breaks for anyone who has them locally. They are now listed in
`.gitignore` with a comment explaining why.

### Dead bookdown config — ignored, history preserved

`_bookdown.yml` and `_output.yml` are bookdown-era files superseded by
`_quarto.yml`; nothing references them. Added to `.gitignore` rather than
deleted, so history is preserved.

---

## 4. Latent working-directory bug fixed

`r-command-line.qmd` and `conclusion.qmd` both read fixtures that live in
`cline/` (`imports_olsrr.txt`, `imports_blorr.txt`, `analysis.R`,
`package_names.txt`) but neither declared `knitr: opts_knit: root.dir: "cline"`,
which the other six chapters do. Those paths therefore resolved from the repo
root.

Harmless today — every affected chunk is `eval=FALSE`, so nothing fails at build
time. It was a trap for the first person to enable one. Both files now declare
`root.dir: "cline"`.

---

## 5. Convention cleanups

| Change | Detail |
|:--|:--|
| `{-}` → `{.unnumbered}` | 6 headings in `index.qmd` |
| README chapter labels | `A`/`B` → `13`/`14`; they render as numbered chapters, since `book.chapters` has no `appendices:` key |
| Outline order | `index.qmd` listed **sudo** before **Data Transfer**; `_quarto.yml` and `README.md` both have Data Transfer 6th, sudo 7th. Reordered |
| Trailing whitespace | `## Summary ` in `conclusion.qmd` |
| Ellipsis in heading | `## What we have not covered...` → no ellipsis |

---

## Verification

Rendered with Quarto **1.6.40** — the version CI pins.

- All 15 chapters render; no errors or warnings.
- Body H1 numbering matches `_quarto.yml` order exactly (table above).
- Sidebar, body heading and in-page TOC are mutually consistent.
- 0 unresolved `??` cross-references.
- 13/13 solutions pointers render.
- New anchors `sec-cheatsheet`, `sec-git-appendix`, `fig-cover` all resolve.

---

## Before committing

- **This renumbers every chapter.** Slugs and URLs are unchanged, so nothing
  404s and `_redirects` is unaffected — but any external reference to
  "chapter N" is now off by one. The README has always stated the corrected
  numbers. Flagging it as a content decision, not a silent change.
- **6 deletions are already staged** in the index as a side effect of
  `git rm --cached`. Everything else is unstaged. They are:
  `analysis.R`, `imports_blorr.txt`, `imports_olsrr.txt`, `release.txt`,
  `zip_example.zip`, `img/J<private-use>`.
- Git reports `LF will be replaced by CRLF` for `index.qmd` and
  `conclusion.qmd`. This is pre-existing repo line-ending behaviour, not
  introduced by these changes, but it may enlarge the diff on next checkout.
- Suggested message: `fix: correct chapter numbering and link every solution`

---

## Not done here (tracked in the workspace checklist)

- No About the Author chapter; no References chapter
- `git-appendix.qmd` renders as chapter 14 rather than living under
  `book.appendices`
- No chapter-number slug gate in CI
- `style.css` is orphaned — `_quarto.yml` has no `css:` key (rdbsql has one)
- Both `google-analytics.html` (legacy UA) and `_ga_partial.html` (GA4) ship
- Trailing whitespace remains in ~14 other headings (cosmetic)