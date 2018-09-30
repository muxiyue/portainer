#!/usr/bin/env bash





# 版本号
VERSION="wondertek-`date "+%Y%m%d%H"`"

REGISTRY_HOST="172.16.1.146"
# 仓库地址前缀
REGISTRY_PREFIX="$REGISTRY_HOST/wondertek/"

USERNAME="admin"
PASSSWD="1qaz!QAZ"

# 中转到本地的地址 使用远程构建和发布
export DOCKER_HOST=tcp://127.0.0.1:2376

function build_and_push_images() {
  docker build -t $REGISTRY_PREFIX"portainer:${VERSION}" -f build/linux/Dockerfile .
#  docker tag  "portainer/portainer:$1-${VERSION}" "portainer/portainer:$1"
  docker login $REGISTRY_HOST -p  $PASSSWD  -u $USERNAME;
  docker push $REGISTRY_PREFIX"portainer:${VERSION}"
#  docker push "portainer/portainer:$1"
}

echo "begin to build and push images...."
build_and_push_images
echo "end to build and push images...."