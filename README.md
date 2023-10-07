# cloud-architecture-assignment-1

This repository hosts the automation scripts and documentation for the SETU M.Sc. - Enterprise Software Systems, Cloud
Architecture module.

Deployed and managed through Infrastructure-as-code by [***OpenTofu!***](https://opentofu.org/docs/language/)

## Requirements

### OpenTofu

Replace:
`distro` - With your relevant distro ['linux','openbsd','darwin','freebsd','solaris','windows']
'arch' - With your relevant architecture ['amd64','arm','arm64','386']

*Note: you may need to run the following with `sudo`*
```shell
export DISTRO=linux
export ARCH=amd64

curl -L https://github.com/opentofu/opentofu/releases/download/v1.6.0-alpha2/tofu_1.6.0-alpha2_"${DISTRO}"_"${ARCH}".zip \
--output opentofu.zip &&\ 
unzip opentofu.zip -d opentofu &&\
mv opentofu/tofu /usr/local/bin/tofu &&\
rm opentofu opentofu.zip -rf


```