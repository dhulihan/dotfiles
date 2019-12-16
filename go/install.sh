set -x
go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/kardianos/govendor
go get -u github.com/golang/protobuf/{proto,protoc-gen-go}
go get -u google.golang.org/grpc
go get -u golang.org/x/tools/refactor/rename
go get -u golang.org/x/tools/gopls
go get -u github.com/jstemmer/gotags
go get -u github.com/jsha/minica
go get -u github.com/gcla/termshark/cmd/termshark
go get -u github.com/fullstorydev/grpcui/cmd/grpcui
go get -u github.com/ashleyschuett/kubernetes-secret-decode
go get -u github.com/salrashid123/gce_metadata_server
go get -u github.com/nshmura/dsio

# bindata
go get -u github.com/jteeuwen/go-bindata/...
go get -u github.com/elazarl/go-bindata-assetfs/...

set +x
