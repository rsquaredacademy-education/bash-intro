# Solutions — sudo

1. Both print tables of installed software (name, version, architecture, short description). Neither modifies the system, so no elevated privileges are needed.
2. `sudo apt-get update` refreshes package lists; `install <pkg>` installs; `remove <pkg>` uninstalls but **keeps** config files; `purge <pkg>` uninstalls and **deletes** configs; `autoremove` drops orphaned dependencies.
3. Installing/removing software writes to system directories (`/usr`, `/etc`) owned by root — hence `sudo`. Listing installed packages only reads the package database, which is world-readable, so any user may run it.
