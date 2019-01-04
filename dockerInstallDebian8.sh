#!/bin/bash
#autor: Leandro z3ta
#Em caso de bugs enviar um email para
#email: leandroz3ta@gmail.com
#Debian Essentials - Install docker


echo "***********************************************************"
echo "*         Debian Essentials  - install docker             *"
echo "*                  Ver. 0.1.0                             *"
echo "*                Use in Debian 8                          *"
echo "***********************************************************"

echo "Você deseja realizar  a configuração do sistema?  Digite 1)Sim  0)Não"
read OPCAO #guarda opção inserida pelo usuário

if [ "$OPCAO" -eq 1 ]; then  #analisa a escolha digitada pelo usuário

    echo "Removendo instalacoes antigas...";
        apt-get -y remove docker docker-engine docker.io;
    echo "Passo 1 - Atualizando sistema...";
        apt-get update && apt-get upgrade && apt-get dist-upgrade;
    echo "Passo 2.1 - Add Docker GPG key...";
        apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D;
    echo "Passo 2.2 - Instalando dependencias...";    
        apt -y install figlet;
        figlet z3ta Tools 1.0;
    echo "Passo 4.1 - Adicionando nova entrada ao repositorio...";
        echo "deb https://apt.dockerproject.org/repo debian-jessie main" >> /etc/apt/sources.list.d/docker.list;
    echo "Passo 4.2 - Instalando certificados...";    
        apt-get -y install apt-transport-https ca-certificates;
    echo "Passo 5 - Atualizando sistema...";
        apt-get update;
    echo "Passo 6 - Instalando Docker...";
        apt-get -y install docker-engine;
    echo "Passo 7 - Validando instalacao do Docker...";
        systemctl start docker;
        systemctl enable docker;
        systemctl status docker;
        docker run hello-world;
    #comando de atualização

    sleep 1 #aguardar 1 segundo depois exibe a mensagem abaixo
    echo "Configurações realizadas com sucesso!"
else
    echo "Sistema não configurado"
    sleep 2
fi
