# Revision Notes — Wave 3 (CI convergence)

**Date:** 2026-10-05
**Scope:** One workflow shape per book; gates that cannot drift
**Author:** automated review pass

Part of a workspace-wide standard for all six books, documented at
[`viz-base/AUTHOR-STANDARDS.md`](https://github.com/rsquaredacademy-education/viz-base/blob/master/AUTHOR-STANDARDS.md).
This file records only what changed in **this** repository.

---

## Summary

- Rename `deploy.yml` to `render.yml` (matches the other books).
- Add `scripts/verify-slugs.sh` — derives the slug list from `_quarto.yml`
  instead of hardcoding it.
- Add a weekly `linkcheck.yml`.
- Make the in-build link check advisory.
- Add an unresolved-cross-reference gate.
- Add `scripts/verify-sitemap.sh` and `scripts/make-sitemap.sh`.

---

## 1. The slug gate was hand-maintained, or absent

This book had **no slug gate at all**. A chapter could fail to render and the
build stayed green — which is exactly how `references.html` went missing from
viz-base during the Quarto migration.

`scripts/verify-slugs.sh` reads the list out of `_quarto.yml` instead:

```sh
slugs=$(yq eval -r '.book.chapters[]?, .book.appendices[]?' "$YAML" \
        | grep '\.qmd$' \
        | sed 's/\.qmd$//')
```

A new chapter is now covered the moment it is declared, rather than the moment
someone remembers to edit a gate.

**One trap worth knowing.** Do not add `set -e` to that script. Under it, a
failing `[ ! -f ]` test can abort the script before the explicit `exit 1`, and
the shell reports success — the gate prints `FAIL` while CI stays green. The
script sets its exit status explicitly and says so in a comment.

---

## 2. The link check was blocking the build on external links

The in-build lychee step had no `continue-on-error`, so a link rotting on a
third-party site failed this book's deploy. Split the two concerns:

- **In-build check: advisory** (`continue-on-error: true`) over staged output.
- **New weekly check: blocking** (`fail: true`), on a cron.

The weekly job runs against the **deployed site**, not `./docs`, because this
book gitignores `docs/` and publishes from the Netlify deploy step. There is no
`./docs` in a fresh clone to scan.

---

## 3. Cross-reference gate

This book carries no `@sec-` references today, so the gate passes trivially. It
is here so that when someone adds one, a broken reference cannot ship silently.
rdbsql carries 5 and viz-base 2, and neither book had a gate for them.

---

## Verification

- All 15 declared chapters pass the slug gate against a real render.
- Removing any page makes it exit non-zero.
- Workflow parses as valid YAML; 17 steps.
- CI green (3m4s, deployed to Netlify).

---

## Commits

| SHA | Message |
|:--|:--|
| `4521a9d` | ci: derive the slug gate from _quarto.yml and check cross-references |

---

## Not done here

- **Shipped to Netlify without a `netlify.toml` copy step** — the file exists at
  the repo root but is not in `project.resources`, so the per-book `[build]` and
  header config is not part of the deployed output. Worth confirming against
  what Netlify is actually configured with.
- **Both analytics files still ship.** `google-analytics.html` (legacy
  `UA-57270671-37`) and `_ga_partial.html` (GA4). Only the latter is wired into
  `_quarto.yml`; the former is referenced only by the dead `_output.yml`.
  Neither is consent-gated, unlike intro-r and viz-base. Wave 9.
- **No About the Author chapter; no References chapter.** Wave 7.
- **`git-appendix.qmd` renders as chapter 14** rather than living under
  `book.appendices`, so the sidebar numbers it alongside content chapters.
  Wave 7.
- **`style.css` is orphaned** — `_quarto.yml` has no `css:` key.
- `scripts/make-sitemap.sh` here keeps its original non-recursive form, because
  this book has no `book.appendices` and nothing renders into a subdirectory.
  The recursive version is used by the books that have appendices. Its
  `google*.html` exclusion is likewise unnecessary here: the only matching file
  is `google-analytics.html`, which is not a `project.resources` entry and so
  never reaches `docs/`.
- `_bookdown.yml` and `_output.yml` are git-ignored (wave 1) but still present
  on disk from before that change.