# Solutions — Input/Output

1. `>` **overwrites** (file holds only `Great Truth`), while `>>` **appends** (file then holds `Great Truth` + `Action of the Toes` = 2 lines). `cat` both times confirms.
2. `release_names.txt` has **30 lines**: first line `Unsuffered Consequences`, last line `Kite Eating Tree`. `head -n 5` shows the first five releases, `tail -n 5` the last five; `tail -n +10` starts at line 10, so it shows 21 lines (30 − 9).
3. `sort -u pkg_names.txt` yields **101 unique lines** (vs 108 total). `sort -r` starts with `WPKDE`. `sort -n package_names.txt` starts with `1. cyclocomp`, `2. odk`, `3. redcapAPI` — numeric order, unlike plain `sort` which would order `14.` before `2.`.
