#!/bin/bash

set -e

URL='https://releases.hashicorp.com/packer/0.8.6/packer_0.8.6_linux_amd64.zip'
VERSION=${BUILD}
curl -k -L -o ${URL##*/} $URL || {
    echo $"URL or version not found!" >&2
    exit 1
}

mkdir -p packer/target/opt/packer
unzip -qq ${URL##*/} -d packer/target/opt/packer

/opt/ruby22/bin/fpm -s dir -t rpm -f \
	-C packer/target \
	-v ${BUILD} \
	-n packer \
	-p packer/target \
	-a amd64 \
        -v ${BUILD} \
        --rpm-ignore-iteration-in-dependencies \
        --description "Simple Packer RPM package for RedHat Enterprise Linux 6" \
        --url "https://github.com/dmatusiewicz/packer-rpm-rhel6" \
        opt/packer

