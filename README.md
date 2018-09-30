# 基于portainer1.19.2进行修改
https://portainer.readthedocs.io/en/1.19.2/contribute.html

## 初始化步骤：
### 安装依赖
$ cd portainer
$ yarn

### 本地构建 打包到dist目录
$ yarn build

### 发布镜像到仓库
仓库地址修改src/github.com/portainer/build/build_and_push_image.sh
$ yarn release

