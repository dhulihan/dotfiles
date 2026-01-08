# Dave's Dotfiles

Contains helpful and highly opinionated tools, aliases, and configuration.

## Features

* Supports `~/.config/<name>` directories
    * Create a `config.<name>` directory in project root
* Supports bash, zsh, etc. Use the following extensions:
    * `.sh` - Helper scripts
    * `.sh-common` - Config files that work on bash AND zsh
    * `.bash` - Loaded from .bashrc
    * `.zsh` - Loaded from .zshrc
* Fun helper functions & scripts
    * directory language detector (`lang`)
    * postgres query tab completion (`pq`) and CSV dumper (`pqdump`)
    * `dev-session` - pulls latest changes and starts up a console/vim session in tmux
    * `secure-note` - Create a sensitive note entry in a keepass database.
    * `backup/restore` - Backup or restore a list of your files using restic.
    * `lkill` - Kill all processing using a TCP port.
* Colored iterm tabs based on directory/project
* Private aliases, functions, and environment variables that aren't included in git (for work-specific goodies)
* Backup and restore helpers
* Vim Stuff
    * Password/secret concealer
    * Custom snippets

## Install

Run this:

```sh
git clone https://github.com/dhulihan/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane OS X
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

### Bash

Make sure this is present in .bash_profile:

    source ~/.bashrc

## Topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## What's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork it](https://github.com/dhulihan/dotfiles/fork), remove what you don't
use, and build on what you do use.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

### functions and binscripts

* functions are good for executing logic in your current shell
* binscripts are good for executing logic in a child shell/process

## Thanks

Forked from holman/dotfiles.
