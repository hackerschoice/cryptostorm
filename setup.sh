#! /bin/bash

set -e

sed 's/\(^[^#].*net.ipv4.conf.all.src_valid_mark.*\)/#\1/g' -i /usr/bin/wg-quick

umask 077
[[ ! -d /etc/wireguard ]] && mkdir /etc/wireguard
cd /etc/wireguard
# Create configuration stubs of all CryptoStorm servers
echo "@@PRIVATEKEY@@" >privatekey
echo "@@PUBLICKEY@@" >publickey
wget --no-verbose https://cryptostorm.is/wg_confgen.txt -O /tmp/confgen.sh
chmod +x /tmp/confgen.sh
/tmp/confgen.sh "@@PSK@@" "@@ADDRESS@@"
rm -f privatekey publickey
mv /etc/wireguard /etc/wireguard-cryptostorm
ln -s /dev/shm/wireguard /etc/wireguard
