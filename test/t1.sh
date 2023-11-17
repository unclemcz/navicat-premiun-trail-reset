function is_installed_v2 {
    dpkg -s $1 >/dev/null 2>&1
    return $?
}

function install_if_missing {
  local cmd=$1
  is_installed_v2 $cmd
  if test $? -ne 0; then
    echo "$cmd not found, installing"
    echo "you may be prompted for your password"
    sudo apt-get install -y $cmd
  fi
}


function is_installed_v3 {
    # echo "package:" $1
    dpkg -s $1 >/dev/null 2>&1
    installed=$?
    echo "installed:" $installed
    if [ $installed -eq 0 ]; then
        echo "installed"
        return 1
    else
        echo "uninstall"
        return 0
    fi
}

install_if_missing dconf-clii
echo $?

