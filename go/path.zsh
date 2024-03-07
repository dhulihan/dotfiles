# use existing gopath, or fallback to $PROJECTS/go
export GOPATH=${GOPATH:-$PROJECTS/go}
export GOBIN=${GOPATH}/bin
export PATH="$GOPATH/bin:$PATH"
export CDPATH=.:$GOPATH/src/github.com:$GOPATH/src/golang.org:$GOPATH/src:$CDPATH

# use testify test generation
export GOTESTS_TEMPLATE=testify
