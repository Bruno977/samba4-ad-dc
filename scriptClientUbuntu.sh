#!bin/bash

#variaveis
serverIp=10.0.1.154
serverName=servidor
serverDomain=tiitanet.local
serverNameAndDomain=servidor.tiitanet.local

#modifica o arquivo /etc/hosts com os dados do servidor
sed -i "/127.0.1.1/a $serverIp  $serverName $serverNameAndDomain" /etc/hosts
