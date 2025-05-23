# lure-repo

Documentation: https://gitea.elara.ws/Elara6331/lure/src/branch/master/docs

Web interface: https://lure.elara.ws

## 食用简述

### lure 安装脚本

该安装脚本会自动下载并安装适用于您系统的 LURE 工具包。直接在终端黏贴如下命令（国内用户记得终端上代理）：
```bash
curl -fsSL lure.sh/install | bash
```

**中药说明**: 这是不推荐的安装方式，因为直接执行 URL 内的内容可能会造成意料之外的事故，为了避免恶意代码，请下载此脚本且检查后再运行。

### 官方分发

打包好的适用于不同发行版的二进制包： https://gitea.arsenm.dev/Arsen6331/lure/releases/latest

LURE 当然是有 AUR 的版本啦： [linux-user-repository-bin](https://aur.archlinux.org/packages/linux-user-repository-bin)

### 添加橙猫猫的 Lure 仓库
```bash
lure ar -n bamcat -u https://github.com/bamdragonfly/lure-repo

### 安装 xivlauncher-cn
```bash
lure in -c xivlauncher-cn
```
### 额外的东西：

**clash-verge-rev**
https://github.com/clash-verge-rev/clash-verge-rev
