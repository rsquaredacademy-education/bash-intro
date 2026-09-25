# scripts/make-fixture.R — one-time fixture generation (Phase 1, Task B2).
# Reads cline/sept_15.csv.gz, extracts header + first 5,000 data rows into
# cline/cran_log_sample.csv.gz, removes build dirt, prunes the 31.7 MB raw
# log, and packages pristine fixtures into seed/cline-seed.tar.gz.
# Location-aware: resolves the repo root from this script's path.
args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
sdir <- if (length(file_arg)) dirname(sub("^--file=", "", file_arg[1])) else "scripts"
root <- normalizePath(file.path(sdir, ".."), mustWork = TRUE)
cline <- file.path(root, "cline")
raw <- file.path(cline, "sept_15.csv.gz")
sample_gz <- file.path(cline, "cran_log_sample.csv.gz")
seed_tar <- file.path(root, "seed", "cline-seed.tar.gz")
N_ROWS <- 5000L

if (!file.exists(raw)) stop("make-fixture.R: missing ", raw)

# 1. Stream header + N_ROWS data rows (never loads the 2.6M-row file).
con <- gzcon(file(raw, "rb"))
header <- readLines(con, n = 1L)
cols <- strsplit(header, ",", fixed = TRUE)[[1L]]
cols <- gsub('^"|"$', "", cols)
stopifnot(
  "column 7 must be package" = length(cols) >= 7L && cols[7L] == "package",
  "column 3 must be size" = length(cols) >= 3L && cols[3L] == "size"
)
rows <- readLines(con, n = N_ROWS)
close(con)
stopifnot("expected 5000 data rows" = length(rows) == N_ROWS)

tmp_csv <- tempfile(fileext = ".csv")
writeLines(c(header, rows), tmp_csv)

# 2. Gzip the sample into cline/.
if (file.exists(sample_gz)) file.remove(sample_gz)
gzcon_out <- gzfile(sample_gz, "wb")
writeLines(c(header, rows), gzcon_out)
close(gzcon_out)
sz_sample <- file.info(sample_gz)$size
cat("cran_log_sample.csv.gz bytes:", sz_sample, "\n")
stopifnot("sample ballooned past 500 KB" = sz_sample < 500L * 1024L)

# 3. Remove known build dirt (fresh patterns appended by later tasks if found).
dirt_dirs <- c("myproject1", "myproject2", "myproject3", "myproject4",
               "r_releases", "r2", "downloads")
for (d in dirt_dirs) {
  p <- file.path(cline, d)
  if (dir.exists(p)) unlink(p, recursive = TRUE, force = TRUE)
}
dirt_files <- c("myanalysis.R", "release_names_2.txt", "release_names_3.txt",
                "spike_probe_ch1.txt", "spike_probe_ch2.txt",
                "rhomepage.html", "index.html")
for (f in dirt_files) {
  p <- file.path(cline, f)
  if (file.exists(p)) file.remove(p)
}
stale_logs <- list.files(cline, pattern = "^sep[t]?_.*\\.csv\\.gz$", full.names = TRUE)
stale_logs <- setdiff(stale_logs, c(sample_gz, raw))
if (length(stale_logs)) file.remove(stale_logs)

# 4. Prune the raw 31.7 MB log (seed tar is canonical from here on).
if (file.exists(raw)) file.remove(raw)

# 5. Package pristine fixtures (reproducible ordering, fixed mtime).
old_wd <- setwd(root)
on.exit(setwd(old_wd), add = TRUE)
if (file.exists(seed_tar)) file.remove(seed_tar)
# suppressWarnings: internal tar's file.info emits benign SID noise on Windows.
suppressWarnings(utils::tar(seed_tar, files = "cline", compression = "gzip",
           tar = "internal"))
sz_seed <- file.info(seed_tar)$size
cat("cline-seed.tar.gz bytes:", sz_seed, "\n")
stopifnot("seed archive exceeds 300 KB budget" = sz_seed < 300L * 1024L)
cat("make-fixture.R: OK\n")
