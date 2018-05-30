## 安装说明
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

设置conf.yaml文件
```
cp conf.yaml.demo conf.yaml  
vim conf.yaml  
```

启动
```
sh run.sh
```

停止
```
sh stop.sh
```
## 配置文件结构
|参数名|描述|
|:-|:-|
|uri|v2ray_whmcs_api的server.php文件所在地址|
|token|与用户数据库通信秘钥|
|node|节点ID 暂时无用|
|rate|倍率|
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