#!/usr/bin/env sh

binary="portainer/cmd/portainer/portainer"

rm -rf portainer/cmd/portainer/$binary


echo "begin to download go dependencies...."

# Grab Go package name
pkgName="github.com/portainer/portainer"

# Grab just first path listed in GOPATH
goPath="${GOPATH%%:*}"

# Construct Go package path
pkgPath="$goPath/src/$pkgName"

# Set-up src directory tree in GOPATH
mkdir -p "$(dirname "$pkgPath")"

# Link source dir into GOPATH
# 暂时屏蔽掉，工程本身就是放在$GOPATH/src下面
#ln -sf $mainPackagePath/../.. "$pkgPath"
cd portainer/cmd/portainer
if [ -e "$pkgPath/vendor" ];
then
    # Enable vendor experiment
    export GO15VENDOREXPERIMENT=1
elif [ -e "$pkgPath/Godeps/_workspace" ];
then
  # Add local godeps dir to GOPATH
  GOPATH=$pkgPath/Godeps/_workspace:$GOPATH
else
  echo "go get all go dependencies...."
  # Get all package dependencies
  `GOOS=${BUILD_GOOS:-""} GOARCH=${BUILD_GOARCH:-""} go get -t -d -v ./...`
fi

cd ../../..
echo "end to download go dependencies...."

echo "begin to build go...."
# $1 $2  如 linux adm64
if [[  -n "$1" ]] && [[ "$1" != "undefined" ]]; then
    binary=$binary"-$1-$2"
    CGO_ENABLED=0 GOOS=$1 GOARCH=$2 go build --installsuffix cgo --ldflags '-s' -o $binary portainer/cmd/portainer/main.go
    mv "$binary" dist/portainer
else
    CGO_ENABLED=0  go build --installsuffix cgo --ldflags '-s' -o $binary portainer/cmd/portainer/main.go
    mv "$binary" dist/
fi
echo "end to build go...."


