## 安装说明
准用系统 Centos 7 + || Debian 7 + 

安装git
```
yum update&&yum install git -y
```

下载文件
```
git clone https://github.com/deepbwork/v2ray-whmcs-backend.git  
cd v2ray-whmcs-backend  
chmod +x ./*.sh
```

安装TLS脚本
```
sh deepbwork.sh tls
```

安装BBR
```
sh deepbwork.sh bbr
```

配置Conf.yaml文件
```
sh deepbwork.sh init
```

启动服务
```
sh deepbwork.sh run
```

停止服务
```
sh deepbwork.sh stop
```


## 配置文件结构
|参数名|描述|
|:-|:-|
|uri|v2ray_whmcs_api的server.php文件所在地址|
|token|与用户数据库通信秘钥|
|node|节点ID 暂时无用|
|port|用户连接端口|
|rate|倍率|
|tls|是否使用TLS 1:启用 0:关闭|
|client|默认|
|tag|默认|
|liscense|授权码|

## 日志
|文件名|描述|
|:-|:-|
|access.log|v2ray服务日志|
|error.log|v2ray服务日志|
|v2ray-service.log|v2ray启动日志|
|v2ray-whmcs.log|v2ray操作日志|
