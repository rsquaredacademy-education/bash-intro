# Solutions — File Management

1. After `touch`, `ls` shows `myexercise.R` (0 bytes). After `cp`, both `release_names.txt` (30 lines) and `release_names_ex.txt` appear. After `rm myexercise.R`, only `release_names_ex.txt` remains — then removed by the final cleanup.
2. `ls ex_releases` shows 1 file (`release_names.txt`). `mv -v` prints something like `renamed 'myexercise2.R' -> 'ex_releases/myexercise2.R'`. Afterwards `ls ex_releases` shows 2 files and plain `ls` no longer shows `myexercise2.R`.
3. `diff` prints `1,4c1,5` with `<` lines (`car`, `checkmate`, `cli`, `clisymbols`) versus `>` lines (same four plus `caret`) — so **`caret`** (present only in `imports_blorr.txt`, which has 5 lines vs 4) is the extra package. `diff -y` shows the two files in adjacent columns; `diff -u` shows a compact unified hunk with `-`/`+` markers and `@@` headers.
