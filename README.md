# Command Line Basics for R Users

![Cover](img/ebook-bash-intro.png)

A gentle introduction to the command line for R users — every shell command mapped to its R equivalent. Free to read, built with [Quarto](https://quarto.org/).

📖 **Read the book:** https://bash-intro.rsquaredacademy.com

[![Launch in Posit Cloud](https://img.shields.io/badge/Posit_Cloud-Launch-blue)](https://posit.cloud/content/13023750)
[![Open in Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/rsquaredacademy-education/bash-intro)

## Syllabus

| # | Chapter | You will learn |
|:--|:--------|:---------------|
| 1 | Introduction | Launch the terminal, `whoami`, `date`, `cal`, `--help`, `tldr` |
| 2 | Navigating File System | `pwd`, `ls`, `cd`, `mkdir`, `rmdir`, permissions basics |
| 3 | File Management | `touch`, `cp`, `mv`, `rm`, `diff` |
| 4 | Input/Output | `echo`, redirection `>`/`>>`, `cat`, `head`, `tail`, `wc`, `sort` |
| 5 | Search & Regular Expression | `grep`, `find` |
| 6 | Data Transfer | `wget`, `curl` (offline-first with local fixtures) |
| 7 | sudo | `apt-get` install/update/remove |
| 8 | File Compression | `tar`, `gzip`, `zip`, `unzip` |
| 9 | System Info | `uname`, `free`, `df`, `sleep`, `history` |
| 10 | R & the Shell | `system2()`, `Rscript`, R Markdown `bash` engine |
| 11 | Conclusion | Wrap-up + integrative exercises |
| A | Shell ↔ R Cheat Sheet | One-page command reference (CC BY-NC-SA 4.0) |
| B | Git in 10 Minutes | Git workflow for RStudio users |

Each chapter ends with 3 hands-on exercises. Worked solutions live in [`solutions/`](solutions/) (one file per chapter, kept out of the rendered book so you can attempt first).

## Zero-setup environments

- **Tier 0 (primary):** Posit Cloud project — 1-click RStudio in the browser (link above).
- **Alternative:** GitHub Codespaces — click the badge above; the `.devcontainer` boots R 4.4.2 + Quarto + fixtures automatically.
- **Local:** Windows (WSL2 or Git Bash), macOS (Terminal/Zsh), Linux (native Bash). See Chapter 1's decision tree.

## Develop

```bash
Rscript scripts/reset-fixture.R   # restore pristine cline/ fixtures
quarto preview                     # live HTML preview
quarto render                      # full book (CI builds each format discretely)
```

CI (`.github/workflows/deploy.yml`) renders HTML, Typst PDF, and ePub on `ubuntu-24.04` (R 4.4.2, Quarto 1.6.40) and deploys `docs/` to Netlify. `master` is the production branch.

## License

CC BY-NC-SA 4.0.
