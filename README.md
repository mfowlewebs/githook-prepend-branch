# Githook Preprend Branch

> A git 'prepare-commit-msg' hook to prepend a ticket number, taken from the current branch name

Find the current branch name, and look for a DG-nnn ticket number in it to prepend into the commit message.

# Usage

To use, copy prepare-commit-msg into the target project's `.git/hooks` directory.

# Upstream

This project derives from [this gist](https://gist.github.com/bartoszmajsak/1396344).
