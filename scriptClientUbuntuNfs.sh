#!bin/bash

sudo apt-get install nfs-common -y

echo "Informe o IP do servidor: "
read serverIp

echo "Informe o caminho do compartilhamento no servidor: "
read nameServer

echo "Informe o caminho do compartilhamento no cliente: "
read nameClient

cat > '/etc/rc.local'<<EOT
#!bin/bash
EOT

sed -i "/bash/a showmount -e $serverIp" /etc/rc.local

sed -i "/showmount/a  mount -t nfs $serverIp:$nameServer $nameClient" /etc/rc.local

sed -i "/nfs/a mount | grep nfs" /etc/rc.local


sed -i "/errors=remount/a $serverIp:$nameServer     $nameClient    nfs     defaults        0       0" /etc/fstab
