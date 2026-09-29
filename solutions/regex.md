# Solutions — Search & Regular Expression

1. `grep R package_names.txt` matches **13 lines** (uppercase `R` only); `grep -i R package_names.txt` matches **53 lines** — `-i` ignores case, so lowercase `r` matches too.
2. Expected output (3 matches):
   ```text
   package_names.txt:59:84. BIOMASS
   package_names.txt:71:92. BioCircos
   package_names.txt:88:7. bayesbio
   ```
   `-H` adds the filename, `-n` the line number.
3. `find r_releases -name '*.txt'` lists the 3 `.txt` files created in Chapter 3. `find -type d -name R` matches only the uppercase directory (`mypackage/R`), while `find -type d -iname R` matches both `mypackage/R` and `r/` — `-iname` is the case-insensitive variant.
