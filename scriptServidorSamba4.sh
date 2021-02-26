#!bin/bash

#variaveis
echo "Digite o IP do servidor"
read serverIp
echo "Digite o network"
read serverNetWork
echo "Digite a Mascara de Rede"
read serverMk
echo "Digite o Broadcast"
read serverBroadCast
echo "Digite o Gateway"
read serverGt
echo "Digite dois DNS"
read serverDns
echo "Informe o nome da placa de rede Exp: "ether0""
read serverRede
cp /etc/network/interfaces /etc/network/interfaces.backup
rm /etc/network/interfaces 
cat > '/etc/network/interfaces' <<EOT
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug $serverRede
        iface $serverRede inet static
        address $serverIp
        network $serverNetWork
        netmask $serverMk
        broadcast $serverBradCast
        gateway $serverGt
        dns-nameservers $serverDns

EOT
