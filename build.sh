#!/usr/bin/env bash
set -euxo pipefail

sudo apt-get update
sudo apt install -y gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev python3-subunit mesa-common-dev zstd liblz4-tool file locales
sudo locale-gen en_US.UTF-8
git clone --depth=1 git://git.yoctoproject.org/poky -b ${BRANCH}
cd poky
source oe-init-build-env
echo 'BB_SIGNATURE_HANDLER = "OEEquivHash"' >> conf/local.conf
echo 'BB_HASHSERVE = "auto"' >> conf/local.conf
echo 'BB_HASHSERVE_UPSTREAM = "hashserv.yocto.io:8687"' >> conf/local.conf
echo 'SSTATE_MIRRORS ?= "file://.* https://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH"' >> conf/local.conf
bitbake core-image-minimal
