#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux

# Abilita COPR per audio Chromebook (HP Elite c1030 / jinlon)
curl -fsSL "https://copr.fedorainfracloud.org/coprs/pvermeer/chromebook-linux-audio/repo/fedora-$(rpm -E %fedora)/pvermeer-chromebook-linux-audio-fedora-$(rpm -E %fedora).repo" \
    -o /etc/yum.repos.d/pvermeer-chromebook-linux-audio.repo

dnf5 install -y chromebook-linux-audio

# Rimuove il file repo dopo l'installazione per mantenere l'immagine pulita
rm -f /etc/yum.repos.d/pvermeer-chromebook-linux-audio.repo

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

