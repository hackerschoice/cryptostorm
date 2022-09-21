#! /bin/bash

sed 's/\(^[^#].*net.ipv4.conf.all.src_valid_mark.*\)/#\1/g' -i /usr/bin/wg-quick

umask 077
cd /etc/wireguard

# Create configuration stubs of all CryptoStorm servers
echo "@@PRIVATEKEY@@" >privatekey
echo "@@PUBLICKEY@@" >publickey
wget --no-verbose https://cryptostorm.is/wg_confgen.txt -O /tmp/confgen.sh
chmod +x /tmp/confgen.sh
/tmp/confgen.sh "@@PSK@@" "@@ADDRESS@@"
rm -f privatekey publickey
