#!/bin/sh
set -e

deluser packer
adduser vagrant <<- EOP
vagrant
vagrant
EOP
addgroup vagrant wheel
sed -i 's/^root:[^:]*:/root:!:/' /etc/shadow

sed -i 's/^#UseDNS .*$/UseDNS no/' /etc/ssh/sshd_config
SSHDIR=/home/vagrant/.ssh
mkdir "${SSHDIR}"
chmod 700 "${SSHDIR}"
apk update
apk add curl
curl -L -o "${SSHDIR}/authorized_keys" http://github.com/hashicorp/vagrant/raw/master/keys/vagrant.pub
chown -R vagrant: "${SSHDIR}"

cat >> /etc/apk/repositories <<- EOR
http://dl-cdn.alpinelinux.org/alpine/edge/community
EOR

apk update
# bash is needed as the default ssh shell used by vagrant (instead "config.ssh.shell" would be mandatory)
apk add bash virtualbox-guest-additions virtualbox-guest-modules-virthardened
cat >> /etc/modules <<- EOM
vboxsf
EOM

exit
