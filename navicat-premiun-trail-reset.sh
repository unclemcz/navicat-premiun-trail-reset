#!/bin/bash


function is_installed {
  command -v $1 >/dev/null 2>&1
}

function install_if_missing {
  local cmd=$1
  if ! is_installed $cmd; then
    echo "$cmd not found, installing"
    echo "you may be prompted for your password"
    sudo apt-get install -y $cmd
  fi
}

# make sure we have installed the following packages
echo "checking packages to run this bash......"
install_if_missing dconf-editor
install_if_missing touch

# let's gogogo
echo "start..."
rm -rf ~/.config/navicat/Premium/preferences.json*
dconf reset -f /com/premiumsoft/
touch -m navicat*.AppImage
echo "Done!"
