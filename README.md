## 安装说明
install git
```
yum update&&yum install git -y
```

download file 
```
git clone https://github.com/deepbwork/v2ray-whmcs-backend.git  
cd v2ray-whmcs-backend  
chmod +x ./*.sh
```

setting conf.yaml
```
cp conf.yaml.demo conf.yaml  
vim conf.yaml  
```

start
```
sh run.sh
```

stop
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
