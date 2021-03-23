 #!bin/bash

#variaveis
serverIp=10.0.1.154
serverName=serverad
serverDomain=tiitanet.local
serverDomainUpCase=TIITANET.LOCAL
serverNameAndDomain=serverad.tiitanet.local
serverNameAndDomainUpCase=SERVERAD.TIITANET.LOCAL

#insere o nome e o dominio do servidor /etc/hosts
sed -i "/127.0.1.1/a $serverIp	$serverName $serverNameAndDomain" /etc/hosts

#atualizações do sistema
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
sudo apt install sssd heimdal-clients msktutil -y

#altera arquivo krb5
sudo mv /etc/krb5.conf /etc/krb5.conf.default

#escreve no arquivo /etc/krb5.conf
cat > '/etc/krb5.conf' <<EOT
[libdefaults]
default_realm = $serverDomainUpCase
rdns = no
dns_lookup_kdc = true
dns_lookup_realm = true

[realms]
$serverDomainUpCase = {
kdc = $serverNameAndDomain
admin_server = $serverNameAndDomain
}
EOT

#colocar senha do administrator
kinit administrator
comp=$?
if [ $comp -eq "1" ];
then
        while [ $comp -eq "1" ]; do
        kinit administrator
        comp=$?
        done
fi
klist
sleep 3
echo 'Informe o nome do PC: '
read namePc

#Maiuscula e minuscula
namePcUpperCase=$(echo $namePc | tr [a-z] [A-Z])
namePcLowerCase=$(echo $namePc | tr [A-Z] [a-z])

#inicializa Kerberos e gera Keytab
msktutil -N -c -b 'CN=COMPUTERS' -s $namePcUpperCase/$namePcLowerCase.$serverDomain -k my-keytab.keytab --computer-name $namePcUpperCase --upn $namePcUpperCase --server $serverNameAndDomain --user-creds-only
msktutil -N -c -b 'CN=COMPUTERS' -s $namePcUpperCase/$namePcLowerCase -k my-keytab.keytab --computer-name $namePcUpperCase --upn $namePcUpperCase~$ --server $serverNameAndDomain --user-creds-only
kdestroy

#configura arquivo Keytap
sudo mv my-keytab.keytab /etc/sssd/my-keytab.keytab
sudo touch  /etc/sssd/sssd.conf

#configura arquivo sssd
cat > '/etc/sssd/sssd.conf' <<EOT
[sssd]
services = nss, pam
config_file_version = 2
domains = $serverDomain

[nss]
entry_negative_timeout = 0
#debug_level = 5

[pam]
#debug_level = 5

[domain/$serverDomain]
#debug_level = 10
enumerate = false
id_provider = ad
auth_provider = ad
chpass_provider = ad
access_provider = ad
dyndns_update = false
ad_hostname = $namePcLowerCase.$serverDomain
ad_server = $serverNameAndDomain
ad_domain = $serverDomain
ldap_schema = ad
ldap_id_mapping = true
fallback_homedir = /home/%u
default_shell = /bin/bash
ldap_sasl_mech = gssapi
ldap_sasl_authid = $namePcUpperCase$
krb5_keytab = /etc/sssd/my-keytab.keytab
ldap_krb5_init_creds = true
EOT

#da permissão no arquivo sssd
sudo chmod 0600 /etc/sssd/sssd.conf

#adiciona linha no arquivo /etc/pam.d/common-session
sed -i "/pam_unix.so/a session required pam_mkhomedir.so skel=/etc/skel umask=0077" /etc/pam.d/common-session

#reinicia o sssd
sudo systemctl restart sssd

#cria o administrador
sudo adduser administrator sudo
su -l administrator

