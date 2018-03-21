#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  if [ -z "$(command -v brew)" ]; then
    # Work around Objective-C fork() changes in 10.13
    export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

    echo "Install Homebrew & Ansible"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # py3 is now default
    brew install python
    brew link python --overwrite
    pip3 install --upgrade pip
    pip3 install --install-option="--prefix=/usr/local" ansible
  fi
fi

ansible-playbook -i localhost.ini system-bootstrap.yaml
