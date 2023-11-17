
echo Detecting OS

DISTRO=$(cat /etc/os-release | grep -E "^ID=" | cut -d= -f 2)

echo Distribution is $DISTRO

## TODO: install packages needed for ansible
case $DISTRO in
    fedora)
      echo Installing Fedora ansible components
      # dnf -y install ansible-core systemd-udev
    ;;
    debian|ubuntu)
      echo Installing Debian ansible components
      # apt-get update && apt-get install -y ansible udev
    ;;
    *)
    echo Unrecognised distro $DISTRO
    ;;
esac