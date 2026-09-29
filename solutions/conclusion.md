# Solutions — Conclusion (integrative)

1. All three list the same `cline/` contents (`release_names.txt`, `pkg_names.txt`, `cran_log_sample.csv.gz`, …). `system2(command = "ls")` prints the shell listing inside R; `Rscript -e "dir()"` prints R's own listing from the shell — agreement proves both see the same working directory.
2. Both return the same matching lines (e.g. the 3 `bio` hits from Chapter 5). Wrapping in `system2(..., stdout = TRUE)` brings shell output into R as a character vector instead of printing it to the terminal.
3. Example: (1) `cd cline`, (2) locate the script with `ls *.R` (or `find . -name '*.R'`), (3) `Rscript analysis.R`. Success evidence: the `head(mtcars)` output in the terminal (`analysis.R` is a one-line script, identical in `cline/` and the repo root).
