# Solutions — R & the Shell

1. The first call prints the directory listing to the R console and returns an exit code invisibly. The second deletes `myexamples/` (created earlier by unzipping `zip_example.zip`) — verify it is gone with `dir()` or a shell `ls`.
2. The `echo` output lands in the file `release.txt` (check with `readLines("release.txt")` → `"Great Truth"`). The `diff` output prints to the R console because `stdout = TRUE` captures command output back into R instead of a file.
3. `Rscript -e "head(mtcars)"` runs the expression and exits without opening the interactive console; `Rscript analysis.R` executes the whole script file the same way; `R -e "…"` launches a full R session, runs the code, then quits. All three print to the terminal, but only the `R -e` form starts the R engine interactively-style.
