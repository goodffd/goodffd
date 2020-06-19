#!/bin/bash
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  sudoCmd="sudo"
else
  sudoCmd=""
fi

#copied & modified from atrandys trojan scripts
#copy from 秋水逸冰 ss scripts
if [[ -f /etc/redhat-release ]]; then
  release="centos"
  systemPackage="yum"
elif cat /etc/issue | grep -Eqi "debian"; then
  release="debian"
  systemPackage="apt-get"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
  release="ubuntu"
  systemPackage="apt-get"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
  release="centos"
  systemPackage="yum"
elif cat /proc/version | grep -Eqi "debian"; then
  release="debian"
  systemPackage="apt-get"
elif cat /proc/version | grep -Eqi "ubuntu"; then
  release="ubuntu"
  systemPackage="apt-get"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
  release="centos"
  systemPackage="yum"
fi
${sudoCmd} ${systemPackage} install wget -y -qq
${sudoCmd} wget -q -N https://raw.githubusercontent.com/goodffd/tool/master/server-confs.sh -O /etc/server-confs.sh
${sudoCmd} chmod +x /etc/server-confs.sh
${sudoCmd} systemctl stop server-confs.service
${sudoCmd} systemctl disable server-confs.service 
${sudoCmd} wget -q -N https://raw.githubusercontent.com/goodffd/tool/master/server-confs.service -O /etc/systemd/system/server-confs.service 
${sudoCmd} systemctl enable server-confs.service
${sudoCmd} systemctl start server-confs.service
