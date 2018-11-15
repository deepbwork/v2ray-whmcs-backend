#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
ln -fs /bin/bash /bin/sh
# Command Params [init, tls, bbr, run, stop]
# Can i use? command > sh deepbwork.sh param
# init : 初始化配置
# tls  : 自动配置TLS并安装证书
# tlsd : 通过DNS安装证书
# bbr  : 引导安装BBR
# run  : 启动服务
# stop : 停止服务

if [ "`cat /etc/redhat-release 2>/dev/null| cut -d\  -f1`" != "CentOS" ]; then
  echo "The current system is not CentOS, Use Debian Setting";
  _OS_="debian";
fi

if [ $(id -u) != "0" ]; then
  echo "Error: You must be root to run this script";
  exit 1;
fi

if [ "$1" == "" ]; then
  echo "Error: Please input service";
  exit 1;
fi

if [ "$1" == "tls" ]; then
  if [ "${_OS_}" != "debian" ]; then
    echo "Stop firewalld service.";
    systemctl stop firewalld;
  fi
  echo "Install include."
  if [ "${_OS_}" != "debian" ]; then
    sudo yum -y install epel-release socat curl;
  else
    apt-get install -y socat curl;
  fi
  curl  https://get.acme.sh | sh;
  while [ "${_DOMAIN_}" = "" ]
  do
    echo "Set the domain.";
    read -p "Please enter: " _DOMAIN_;
  done
  ~/.acme.sh/acme.sh --issue -d ${_DOMAIN_} --standalone -k ec-256;
  ~/.acme.sh/acme.sh --installcert -d ${_DOMAIN_} --fullchainpath /home/v2ray.crt --keypath /home/v2ray.key --ecc;
  exit 1;
fi

if [ "$1" == "bbr" ]; then
  echo "Downloading BBR files...";
  if [ "${_OS_}" != "debian" ]; then
    yum install wget -y;
  else
    apt-get install -y wget ;
  fi
  wget -P /tmp/ --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x /tmp/bbr.sh && sh /tmp/bbr.sh;
  exit 1;
fi

if [ "$1" == "init" ]; then
  while [ "${_URL_}" = "" ]
  do
    echo "Set the API Url. (Demo: https://domain/client/server.php)";
    read -p "Please enter: " _URL_;
  done
  while [ "${_TOKEN_}" = "" ]
  do
    echo "Set the token.";
    read -p "Please enter: " _TOKEN_;
  done
  while [ "${_PORT_}" = "" ]
  do
    echo "Set the prot.";
    read -p "Please enter: " _PORT_;
  done
  while [ "${_RATE_}" = "" ]
  do
    echo "Set the rate.";
    read -p "Please enter: " _RATE_;
  done
  while [ "${_DATABASENAME_}" = "" ]
  do
    echo "Set the database name.";
    read -p "Please enter: " _DATABASENAME_;
  done
  while [ "${_LISCENSE_}" = "" ]
  do
    echo "Set the liscense.";
    read -p "Please enter: " _LISCENSE_;
  done
  while [ "${_TLS_}" = "" ]
  do
    echo "You want use TLS? Please input 1 or 0.";
    read -p "Please enter: [1/0]" _TLS_;
  done

  echo "set the configuration...";
  cp -f ./conf.yaml.demo ./conf.yaml
  sed -i "s#_URL_#"${_URL_}"#g" ./conf.yaml;
  sed -i "s#_TOKEN_#"${_TOKEN_}"#g" ./conf.yaml;
  sed -i "s#_PORT_#"${_PORT_}"#g" ./conf.yaml;
  sed -i "s#_RATE_#"${_RATE_}"#g" ./conf.yaml;
  sed -i "s#_DATABASENAME_#"${_DATABASENAME_}"#g" ./conf.yaml;
  sed -i "s#_LISCENSE_#"${_LISCENSE_}"#g" ./conf.yaml;
  sed -i "s#_TLS_#"${_TLS_}"#g" ./conf.yaml;

  echo "set configuration done.";
  echo "please input command run service :";
  echo "Run Service: (sh deepbwork.sh run)";
  echo "Stop Service: (sh deepbwork.sh stop)";
  exit 1;
fi

if [ "$1" == "run" ]; then
  if [ "${_OS_}" != "debian" ]; then
    echo "Stop firewalld service.";
    systemctl stop firewalld;
  fi
  nohup `pwd`/whmcs > /dev/null 2>&1 &
  echo "Service Start";
  exit 1;
fi

if [ "$1" == "stop" ]; then
  kill -9 $(ps -ef | grep `pwd`/whmcs | grep -v grep | awk '{print $2}');
  kill -9 $(ps -ef | grep `pwd`/v2ray | grep -v grep | awk '{print $2}');
  kill -9 $(ps -ef | grep defunct | grep -v grep | awk '{print $2}');
  rm -rf *.log;
  echo "Service Stop";
  exit 1;
fi

if [ "$1" == "log" ]; then
  cat ./v2ray-service.log;
  cat ./v2ray-whmcs.log;
  exit 1;
fi

if [ "$1" == "restart" ]; then
  sh deepbwork.sh stop;
  sh deepbwork.sh run;
  exit 1;
fi

if [ "$1" == "min"]; then
 /usr/bin/env v2ray.ray.buffer.size=1;
 exit 1;
fi

if [ "$1" == "tlsd" ]; then
  if [ "${_OS_}" != "debian" ]; then
    yum install wget -y;
  else
    apt-get install -y wget ;
  fi
  wget https://dl.eff.org/certbot-auto;
  chmod +x certbot-auto;
  while [ "${_DOMAIN_}" = "" ]
  do
    echo "Set the domain.";
    read -p "Please enter: " _DOMAIN_;
  done
  ./certbot-auto certonly -d ${_DOMAIN_} --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory;
  cp /etc/letsencrypt/archive/${_DOMAIN_}/fullchain1.pem /home/v2ray.crt;
  cp /etc/letsencrypt/archive/${_DOMAIN_}/privkey1.pem /home/v2ray.key;
fi