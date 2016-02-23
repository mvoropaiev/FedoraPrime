#!/usr/bin/env bash
set -e

if [[ $EUID -ne 0 ]]; then
   printf "This script must be run as root.\n" 1>&2
   exit 1
fi

case $1 in
  install )
    mkdir -p '/etc/fedora-prime'

    # install etc files
    etc_files=(
      'ld.intel.conf'
      'ld.nvidia.conf'
      'xinitrc.nvidia'
      'xorg.nvidia.conf.template'
    )
    for file in "${etc_files[@]}"; do
      cp "$file" "/etc/fedora-prime/$file"
    done

    # install blacklist
    cp 'blacklist-nouveau.conf' '/etc/modprobe.d/blacklist-nouveau.conf'

    # install fedora-prime-select
    cp 'fedora-prime-select' '/usr/sbin/fedora-prime-select'

    # install service
    cp 'fedora-prime.service' '/usr/lib/systemd/system/fedora-prime.service'
    systemctl enable fedora-prime.service
    printf 'Installation completed.\n'
    ;;
  uninstall )
    systemctl disable fedora-prime.service
    rm -rf '/etc/fedora-prime'
    rm '/usr/sbin/fedora-prime-select'
    rm '/etc/modprobe.d/blacklist-nouveau.conf'
    printf "Successfully uninstalled.\n"
    ;;
  * )
    printf "Usage: %s install|uninstall\n" "$0" 1>&2
    exit 1
    ;;
esac
