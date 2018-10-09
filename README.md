# 基于portainer1.19.2进行修改
https://portainer.readthedocs.io/en/1.19.2/contribute.html

## 初始化步骤：
### 安装依赖
$ cd portainer
$ yarn

### 本地构建 打包到dist目录

#### go打包

> 将外层portainer软链接到$GOPATH/src下面portainer文件夹。

> 某些依赖可能无法下载，如go get -u -v golang.org/x/net/websocket
   需要翻墙操作或者使用手动处理。
> 手动处理方式： golang 在 github 上建立了一个镜像库，如 https://github.com/golang/net 即是 https://golang.org/x/net 的镜像库.
获取 golang.org/x/net 包，只需要以下步骤：\
mkdir -p $GOPATH/src/golang.org/x \
cd $GOPATH/src/golang.org/x  \
git clone https://github.com/golang/net.git  

$ yarn build





### 发布镜像到仓库
仓库地址修改src/github.com/portainer/build/build_and_push_image.sh
$ yarn release

