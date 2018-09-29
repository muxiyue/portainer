#!/bin/bash

export GOPATH=~/go
export BUILD_GOOS=darwin
export BUILD_GOARCH=amd64

BUILD_GOOS=${BUILD_GOOS:-""}
BUILD_GOARCH=${BUILD_GOARCH:-""}

echo "BUILD_GOOS-> $BUILD_GOOS"
echo "BUILD_GOARCH-> $BUILD_GOARCH"

#if ( find /src -maxdepth 0 -empty | read v );
#then
#  echo "Error: Must mount Go source code into /src directory"
#  exit 990
#fi


echo "1  -> $1"

# Grab Go package name
mainPackagePath=$1
if [[ ! -z "${mainPackagePath}" ]];
then
  pkgName="$(cd ${mainPackagePath} && go list -e -f '{{.ImportComment}}' 2>/dev/null || true)"
else
  pkgName="$(go list -e -f '{{.ImportComment}}' 2>/dev/null || true)"
fi

echo "pkgName  -> $pkgName"

if [ -z "$pkgName" ];
then
  echo "Error: Must add canonical import path to root package"
  exit 992
fi

# Grab just first path listed in GOPATH
goPath="${GOPATH%%:*}"

echo "goPath  -> $goPath"

# Construct Go package path
pkgPath="$goPath/src/$pkgName"

# Set-up src directory tree in GOPATH
mkdir -p "$(dirname "$pkgPath")"

# Link source dir into GOPATH
ln -sf $mainPackagePath/../.. "$pkgPath"

if [ -e "$pkgPath/vendor" ];
then
    # Enable vendor experiment
    export GO15VENDOREXPERIMENT=1
elif [ -e "$pkgPath/Godeps/_workspace" ];
then
  # Add local godeps dir to GOPATH
  GOPATH=$pkgPath/Godeps/_workspace:$GOPATH
else
  # Get all package dependencies
  `GOOS=${BUILD_GOOS:-""} GOARCH=${BUILD_GOARCH:-""} go get -t -d -v ./...`
fi

echo "GOPATH  -> $GOPATH"

echo "GOOS  -> $GOOS"
