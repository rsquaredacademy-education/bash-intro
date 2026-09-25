# reset-spike-fixture.R — B0 spike only (mirrors scripts/reset-fixture.R for real cline/)
# Run from spike/ directory (Quarto pre-render cwd is project dir).
spike_dir <- if (basename(getwd()) == "spike") "." else "spike"
stub <- file.path(spike_dir, "cline-stub")
if (dir.exists(stub)) unlink(stub, recursive = TRUE, force = TRUE)
dir.create(stub, showWarnings = FALSE, recursive = TRUE)
seeds <- list.files(file.path(spike_dir, "seed-stub"), full.names = TRUE)
file.copy(seeds, stub)
