# Solutions — System Info

1. `uname -mp` → machine/processor (e.g. `x86_64 x86_64`); `uname -srv` → kernel name, release, version (e.g. `Linux 6.8.0 …`); `uname -a` → everything on one line.
2. `free` shows total/used/free/available RAM and swap (values in kibibytes by default). `df` shows each mounted filesystem with size, used, available, use %, and mount point. Exact numbers vary by machine.
3. `time` reports `real` ≈ 2.0s (`user`/`sys` near 0 — sleeping consumes no CPU). `history` lists the commands with line numbers, including the `time sleep 2` invocation itself.
