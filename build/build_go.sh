#!/usr/bin/env sh

binary="portainer/cmd/portainer/portainer"

rm -rf portainer/cmd/portainer/$binary

echo "begin to build go...."
# $1 $2  如 linux adm64
if [  -n "$1" ]; then
    binary=$binary"-$1-$2"
    CGO_ENABLED=0 GOOS=$1 GOARCH=$2 go build -a --installsuffix cgo --ldflags '-s' -o $binary portainer/cmd/portainer/main.go
    mv "$binary" dist/portainer
else
    CGO_ENABLED=0  go build -a --installsuffix cgo --ldflags '-s' -o $binary portainer/cmd/portainer/main.go
    mv "$binary" dist/
fi
echo "end to build go...."


