kill -9 $(ps -ef | grep v2ray | grep -v grep | awk '{print $2}')
rm -rf *.log