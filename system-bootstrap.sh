#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  if [ -z "$(command -v brew)" ]; then
    # Work around Objective-C fork() changes in 10.13
    export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

    echo "Install Homebrew & Ansible"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # py3 is now default
    brew upgrade python || brew install python
    brew unlink python && brew link python --overwrite
  fi
  /usr/local/bin/pip3 install --upgrade pip setuptools wheel
  /usr/local/bin/pip3 install --upgrade --install-option="--prefix=/usr/local" ansible
fi

if [ -f "/etc/fedora-release" ] ; then
  sudo dnf install python3-devel python3-pip gcc libffi-devel openssl-devel
  sudo env "PATH=${PATH}" /usr/bin/pip3 install --upgrade pip setuptools wheel
  sudo env "PATH=${PATH}" /usr/bin/pip3 install --prefix=/usr/local ansible
fi

ansible-playbook -i localhost.ini -K system-bootstrap.yaml
