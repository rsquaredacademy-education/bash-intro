# Solutions — Data Transfer

1. `wget_demo.csv.gz` is created locally (same byte size as `cran_log_sample.csv.gz`, ~48 KB). The `file://` scheme reads from disk, so nothing is downloaded.
2. `cmp` prints nothing and exits 0 — the two copies are byte-identical. (`ls -lh` shows equal sizes as a weaker check.)
3. Command: `wget -P downloads -i urls.txt`. `-P downloads` sets the directory prefix (all files saved under `downloads/`); `-i urls.txt` reads the URLs to fetch from `urls.txt` (which lists three `cran-logs.rstudio.com` daily log URLs) instead of the command line.
