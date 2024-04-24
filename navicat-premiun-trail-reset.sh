#!/bin/bash
# version:0.0.3

function is_installed {
    dpkg -s $1 >/dev/null 2>&1
    return $?
}

function install_if_missing {
  local cmd=$1
  is_installed $cmd
  if test $? -ne 0; then
    echo "$cmd not found, installing"
    echo "you may be prompted for your password"
    sudo apt-get install -y $cmd
  fi
}

echo Detecting OS
DISTRO=$(cat /etc/os-release | grep -E "^ID=" | cut -d= -f 2)
echo Distribution is $DISTRO

# make sure we have installed the following packages
# echo "checking packages to run this bash......"
case $DISTRO in
    uos)
      echo install_if_missing uos dependent packages
      install_if_missing dconf-editor
      install_if_missing dconf-cli
    ;;
    debian|ubuntu)
      echo install_if_missing Debian dependent packages
      install_if_missing dconf-editor
    ;;
    *)
    echo Unrecognised distro $DISTRO,exit
    exit
    ;;
esac


# let's gogogo
echo "start..."
rm -rf ~/.config/navicat/Premium/preferences.json*
dconf reset -f /com/premiumsoft/
touch -cm navicat*.AppImage
echo "Done!"

