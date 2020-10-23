# Use git template directory when creating or cloning projects.
git config --global init.templatedir '~/.git_template'

# global gitignore
git config --global core.excludesfile ~/.gitignore_global

# autosquash
git config --global rebase.autosquash true

# rebase to reconcile pulls
git config --global pull.rebase true
