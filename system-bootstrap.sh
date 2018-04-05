#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  if [ -z "$(command -v brew)" ]; then
    # Work around Objective-C fork() changes in 10.13
    export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

    echo "Install Homebrew & Ansible"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # py3 is now default
    brew install python
    brew unlink python && brew link python --overwrite
  fi
  pip3 install --upgrade pip setuptools wheel
  pip3 install --install-option="--prefix=/usr/local" ansible
fi

if [ -f "/etc/fedora-release" ] ; then
  sudo dnf install python3-pip
  sudo env "PATH=${PATH}" pip3 install --upgrade pip setuptools wheel
  sudo env "PATH=${PATH}" pip3 install --install-option="--prefix=/usr/local" ansible
fi

ansible-playbook -i localhost.ini system-bootstrap.yaml
