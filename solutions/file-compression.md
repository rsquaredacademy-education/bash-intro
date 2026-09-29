# Solutions — File Compression

1. `tar -tvf release_names.tar` lists `release_names.txt`, `release_names_18.txt`, `release_names_19.txt`. `unzip -l main_project.zip` lists the `myproject/` tree (`README.md`, `run_analysis.R`, `data/`, `src/`, …). No files are created by either command.
2. You should see the CSV header plus the first two data rows:
   ```text
   "date","time","size","r_version","r_arch","r_os","package","version","country","ip_id"
   "2019-09-15","02:28:38",47952,NA,NA,NA,"aws.s3","0.3.12","US",1
   ...
   ```
   `cran_log_sample.csv.gz` remains compressed (`ls *.gz` unchanged).
3. `tar -tvf myarchive.tar` shows both added files; `unzip -l myarchive.zip` shows the zipped file with its original and compressed sizes. After `rm myarchive*`, `ls` confirms all three artifacts are gone.
