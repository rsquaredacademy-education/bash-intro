# reset-spike-fixture.R — B0 spike only (mirrors scripts/reset-fixture.R for real cline/)
# Location-aware: resolves paths relative to this script, works from any cwd.
args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
proj_dir <- if (length(file_arg)) dirname(sub("^--file=", "", file_arg[1])) else "."
stub <- file.path(proj_dir, "cline-stub")
if (dir.exists(stub)) unlink(stub, recursive = TRUE, force = TRUE)
dir.create(stub, showWarnings = FALSE, recursive = TRUE)
seeds <- list.files(file.path(proj_dir, "seed-stub"), full.names = TRUE)
ok <- file.copy(seeds, stub)
if (!all(ok)) stop("reset-spike-fixture.R: failed to copy seed files")
