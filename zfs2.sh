#!/bin/sh
INST_LINVAR=linux
INST_LINVER=$(pacman -Qi ${INST_LINVAR} | grep Version | awk '{ print $3 }')
if [ "${INST_LINVER}" = \
"$(pacman -Si ${INST_LINVAR}-headers | grep Version | awk '{ print $3 }')" ]; then
 pacman -S --noconfirm --needed ${INST_LINVAR}-headers
else
 pacman -U --noconfirm --needed \
 https://archive.artixlinux.org//packages/l/${INST_LINVAR}-headers/${INST_LINVAR}-headers-${INST_LINVER}-x86_64.pkg.tar.zst
fi
pacman -Sy --needed --noconfirm zfs-dkms glibc
sed -i 's/#IgnorePkg/IgnorePkg/' /etc/pacman.conf
sed -i "/^IgnorePkg/ s/$/ ${INST_LINVAR} ${INST_LINVAR}-headers/" /etc/pacman.conf
modprobe zfs
