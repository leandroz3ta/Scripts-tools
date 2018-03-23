#!/bin/bash
#autor: Leandro z3ta  
#Em caso de bugs enviar um email para
#email: leandroz3ta@gmail.com
#Zabbix requeriments 


echo "***********************************************************"
echo "*              Zabbix Requeriments                        *"
echo "*                  Ver. 0.1.0                             *"
echo "*              Zabbix target: 3.x.x                       *"
echo "*              OS target: Debian 8                        *"
echo "***********************************************************"

echo "Você deseja realizar  a configuração do sistema para instalação do zabbix 3.x.x?  Digite 1 para SIM ou 0 para NÃO."
read OPCAO #guarda opção inserida pelo usuário

if [ "$OPCAO" -eq 1 ]; then  #analisa a escolha digitada pelo usuário

    echo "===> Passo 1 - Gravando novas entradas na lista de repositorios..."; 
	echo "deb http://http.debian.net/debian/ jessie main non-free contrib" >> /etc/apt/sources.list; 
	echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list; 
	echo "deb http://http.debian.net/debian/ jessie-updates main contrib non-free" >> /etc/apt/sources.list; 
	echo "deb http://http.debian.net/debian/ jessie-backports main contrib non-free" >> /etc/apt/sources.list; 
	echo "===> Passo 2 - Atualizando lista de repositorios..."; 
	apt-get update; 
	echo "===> Passo 3 - Instalando pacotes essenciais..."; 
	apt-get -y install build-essential snmp vim libssh2-1-dev libssh2-1 libopenipmi-dev libsnmp-dev wget libcurl4-gnutls-dev fping libxml2 libxml2-dev curl libcurl3-gnutls libcurl3-gnutls-dev libiksemel-dev libiksemel-utils libiksemel3 sudo; 
	echo "===> Passo 4 - Gravando URL de download do Java na lista de repositorios..."; 
	echo "===> deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list; 
	echo "===> Passo 5 - Gerando chaves de validacao..."; 
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886; 
	echo "===> Passo 6 - Atualizando lista de repositorios..."; 
	apt-get update; 
	echo "===> Passo 7 - Instalando Oracle Java..."; 
	apt-get -y install oracle-java8-installer oracle-java8-set-default; 
	echo "===> Passo 8 - Atualizando lista de repositorios..."; 
	apt-get update; 
	echo "===> Passo 9 - Instalando MySql server..."; 
	apt-get install -y mysql-server; 
	echo "===> Passo 10 - Inicializando Mysql server..."; 
	service mysql start; 
	echo "===> Passo 11 - Instalando servidor Apache..."; 
	apt-get install -y apache2 php5 php5-mysql libapache2-mod-php5 php5-gd php-net-socket libpq5 libpq-dev mysql-server mysql-client libmysqld-dev phpmyadmin libevent-dev; 
    #comando de atualização 
    
    sleep 1 #aguardar 1 segundo depois exibe a mensagem abaixo
    echo "Configurações realizadas com sucesso!"
else
    echo "Sistema não configurado"
    sleep 2
fi
