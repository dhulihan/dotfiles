set -x
go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/kardianos/govendor
go get -u github.com/golang/protobuf/{proto,protoc-gen-go}
go get -u google.golang.org/grpc
go get -u golang.org/x/tools/refactor/rename

# bindata
go get github.com/jteeuwen/go-bindata/...
go get github.com/elazarl/go-bindata-assetfs/...

# termshark
go get github.com/gcla/termshark/cmd/termshark

# grpcui
go get github.com/fullstorydev/grpcui/cmd/grpcui

set +x
