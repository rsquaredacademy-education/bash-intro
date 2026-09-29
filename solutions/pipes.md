# Solutions — Pipes & Redirection

1. Top of the output is `124 rsconnect`, 10 lines total. Full top 10: rsconnect 124, magrittr 122, aws.s3 115, aws.ec2metadata 108, ggplot2 93, stringr 47, rlang 47, dplyr 45, testthat 44, ellipsis 44.
2. Top of the country ranking is `1959 NL`, followed by `1376 US` and `718 IT`. Only the field number changes (`-f9` instead of `-f7`); every other stage is identical.
3. Without `tail -n +2`, the header's 7th field `"package"` survives `cut`, and after quote-stripping it counts as a package named `package` with count 1. `tail -n +2` (start output at line 2) removes the header before counting.
