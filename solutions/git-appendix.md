# Solutions — Appendix: Git in 10 Minutes

1. `git status --short` reports `?? notes.R` — untracked, so nothing is staged
   yet and no commit exists. After `git add notes.R` the `??` becomes `A`, and
   `git commit -m "docs: first notes"` records it. `git log --oneline` then shows
   exactly one line, ending in the message you supplied.

2. `git status --short` reports ` M notes.R` — a leading space then `M`, meaning
   *modified but unstaged*. Stage it and commit; `git log --oneline` now shows
   two lines, newest first, so `docs: second notes` sits above
   `docs: first notes`. Compare `??` (never tracked) with ` M` (tracked and
   changed) — the first column is the index, the second the working tree.

3. After writing `*.html` to `.gitignore` and creating `report.html`, `git status`
   does not mention `report.html`; `git check-ignore -v report.html` confirms why
   by naming the rule that matched. Note that `.gitignore` itself now appears as
   `?? .gitignore` — it is a normal tracked file and still needs staging if you
   want the rule shared with collaborators. `rm report.html` removes the file from
   disk; the ignore rule still applies to any future `*.html`.