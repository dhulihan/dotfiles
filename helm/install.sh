# create plugins dir
mkdir -p $(helm home)/plugins

# helm diff
helm plugin install https://github.com/databus23/helm-diff --version master
