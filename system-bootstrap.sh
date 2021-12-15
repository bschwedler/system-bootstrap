#!/bin/bash

if [ -f "/etc/fedora-release" ] ; then
  sudo dnf install python3-devel python3-pip gcc libffi-devel openssl-devel
  sudo env "PATH=${PATH}" /usr/bin/pip3 install --upgrade pip setuptools wheel
  sudo env "PATH=${PATH}" /usr/bin/pip3 install --prefix=/usr/local ansible
fi

ansible-playbook -i localhost.ini -K -e bootstrap_user=$(whoami) system-bootstrap.yaml
