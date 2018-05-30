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
