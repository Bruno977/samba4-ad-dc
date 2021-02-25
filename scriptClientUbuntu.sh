#!bin/bash

#variaveis
serverIp=10.0.1.154
serverName=servidor
serverDomain=tiitanet.local
serverDomainUpCase=TIITANET.LOCAL
serverNameAndDomain=servidor.tiitanet.local
serverNameAndDomainUpCase=SERVIDOR.TIITANET.LOCAL



#modifica o arquivo /etc/hosts com os dados do servidor
#sed -i "/127.0.1.1/a $serverIp	$serverName $serverNameAndDomain" /etc/hosts



#altera arquivo krb5
#sudo mv /etc/krb5.conf /etc/krb5.conf.default
#cria arquivo /etc/krb5.conf
#touch /etc/krb5.conf




#escreve no arquivo /etc/krb5.conf
#cat > '/etc/krb5.conf' <<EOT
#[libdefaults]
#default_realm = $serverDomainUpCase
#rdns = no
#dns_lookup_kdc = true
#dns_lookup_realm = true

#[realms]
#$serverDomainUpCase = {
#kdc = $serverNameAndDomain
#admin_server = $serverNameAndDomain
#}
#EOT




#colocar senha do administrator
#kinit administrator
#klist
#sleep 3


echo 'Informe o nome do PC: '
read namePc

namePcUpperCase=$(echo $namePc | tr [a-z] [A-Z])
namePcLowerCase=$(echo $namePc | tr [A-Z] [a-z])

echo $namePcLowerCase

