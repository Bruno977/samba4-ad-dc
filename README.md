# Script active directory <img src="https://img.shields.io/static/v1?label=activedirectory&message=samba4&color=blue&style=for-the-badge"/>

<h2> Sistema AD/DC - Debian e cliente ubuntu</h2><br>
<h3> Autenticar ubuntu no servidor active directory </h3>

1) Baixar os arquivos do repositorio
2) Extrair os arquivos.
```
$ unzip nomedoarquivo
```
Caso não tenho o **unzip**, para instalar, use: 
```
$ sudo apt install unzip
```
3)Abra o arquivo **scriptClientUbuntu.sh** com um editor de sua preferencia ou com o bloco de notas e altera as seguintes linhas:
```
$ serverIp=10.0.1.154 *ip do seu servidor*
$ serverName=servidor *nome do seu servidor*
$ serverDomain=tiitanet.local *nome do dominio do servidor*
$ serverDomainUpCase=TIITANET.LOCAL *nome do dominio do servidor em maiusculo*
$ serverNameAndDomain=servidor.tiitanet.local *nome completo do servidor*
$ serverNameAndDomainUpCase=SERVIDOR.TIITANET.LOCAL *nome completo do servidor em maisculo*
``` 
4) Abra o terminal e adicione permissão ao arquivo
```
$ sudo chmod +x scriptClientUbuntu.sh
```
5) Execute o arquivo o arquivo
```
sh scriptClientUbuntu.sh
```
6) Após executar o script, irá abrir uma janela referente ao kerberos, escreva as seguintes informações:
```
nome do dominio do servidor, ex:
$ 10.0.1.154
nome do servidor, ex:
$ serverad
digite novamente o nome do servidor, ex:
$ serverad
```
7) Logo após, informe a senha cadastrada no servidor

8) Logo após, informe o nome do PC, caso não saiba, execute o seguinte comando no terminal:
```
$ hostname
```
