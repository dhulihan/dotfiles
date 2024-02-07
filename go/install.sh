set -x
go get -u github.com/ashleyschuett/kubernetes-secret-decode
go get -u github.com/davecgh/go-spew/spew
go get -u github.com/erning/gorun
go get -u github.com/facebook/ent/cmd/entc
go get -u github.com/fullstorydev/grpcui/cmd/grpcui
go get -u github.com/gcla/termshark/cmd/termshark
go get -u github.com/golang/protobuf/{proto,protoc-gen-go}
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
go get -u github.com/jsha/minica
go get -u github.com/jstemmer/gotags
go get -u github.com/kardianos/govendor
go get -u github.com/nshmura/dsio
go get -u github.com/projectdiscovery/httpx/cmd/httpx
go get -u github.com/projectdiscovery/subfinder/cmd/subfinder
go get -u github.com/rogpeppe/gohack
go get -u github.com/salrashid123/gce_metadata_server
go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/gopls
go get -u google.golang.org/grpc
go get -u github.com/kyleconroy/sqlc/cmd/sqlc
go get -u github.com/buraksezer/olric/cmd/olricd
go get -u github.com/buraksezer/olric/cmd/olric-cli
go get -u github.com/asciimoo/wuzz
go get -u github.com/qeesung/image2ascii
go get -u github.com/google/gops

# bindata
go get -u github.com/jteeuwen/go-bindata/...
go get -u github.com/elazarl/go-bindata-assetfs/...

go install github.com/go-delve/delve/cmd/dlv@latest

go install -v golang.org/x/tools/cmd/gorename@latest
go install -v github.com/google/gops@latest
go install -v github.com/jnewmano/grpc-json-proxy@latest
go install -v github.com/dhulihan/grump@latest
go install -v github.com/dhulihan/httpeeved@latest
go install -v github.com/golang/mock/mockgen@latest
go install -v mvdan.cc/gofumpt@latest
go install github.com/a-h/templ/cmd/templ@latest

go install github.com/rakyll/gotest@latest
go install github.com/dhulihan/emoji-hash@latest

# spanner
go install -v go.mercari.io/yo@latest


# install with brew to ensure stability
# https://golangci-lint.run/usage/install/#local-installation
brew install golangci-lint
brew install golang-migrate

# interactive grpc client
go install github.com/vadimi/grpc-client-cli/cmd/grpc-client-cli@latest

go install honnef.co/go/tools/cmd/staticcheck@latest
go install github.com/dhulihan/depoch@latest

set +x
