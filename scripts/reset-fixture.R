# scripts/reset-fixture.R — restore pristine cline/ from seed (pre-render hook).
# Location-aware: resolves the repo root from this script's path, so it works
# both as `Rscript scripts/reset-fixture.R` (repo root) and as a Quarto
# project.pre-render hook (project-dir cwd).
args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
sdir <- if (length(file_arg)) dirname(sub("^--file=", "", file_arg[1])) else "scripts"
root <- normalizePath(file.path(sdir, ".."), mustWork = TRUE)
cline <- file.path(root, "cline")
seed_tar <- file.path(root, "seed", "cline-seed.tar.gz")
if (!file.exists(seed_tar)) stop("reset-fixture.R: missing ", seed_tar)
if (dir.exists(cline)) unlink(cline, recursive = TRUE, force = TRUE)
old_wd <- setwd(root)
on.exit(setwd(old_wd), add = TRUE)
utils::untar(seed_tar, exdir = ".")
