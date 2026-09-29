# Solutions — Navigating File System

1. The second `ls` lists `practice_nav`; after `rmdir`, the third `ls` no longer shows it. `mkdir` creates an empty directory, `rmdir` removes an empty directory.
2. Expected `pwd` sequence (paths end with): `.../cline` → `.../cline/r` → `.../cline` → `.../cline/r` → your home directory → `.../cline/r`. `cd -` always returns to the previous directory; `~` is shorthand for home.
3. `-a` adds dotfile entries (`.` and `..` plus hidden files); `-h` shows sizes like `546` bytes as readable units alongside `-l`; `-lS` orders largest first; `-ltr` orders oldest first, so the **last** line is the most recently modified file. To find the most recently modified file, use `ls -ltr` (or `ls -lt | head`).
