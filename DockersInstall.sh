#!/bin/bash
#autor: Leandro z3ta
#Em caso de bugs enviar um email para
#email: leandroz3ta@gmail.com
#Debian Essentials - Install docker


echo "***********************************************************"
echo "*         Debian Essentials  - install docker             *"
echo "*                  Ver. 0.1.0                             *"
echo "*                Use in Debian 9                          *"
echo "***********************************************************"

echo "Você deseja realizar  a configuração do sistema?  Digite 1)Sim  0)Não"
read OPCAO #guarda opção inserida pelo usuário

if [ "$OPCAO" -eq 1 ]; then  #analisa a escolha digitada pelo usuário

    echo "Removendo instalacoes antigas...";
        apt-get -y remove docker docker-engine docker.io;
    echo "Passo 1 - Atualizando sistema...";
        apt-get update;
    echo "Passo 2 - Instalando dependencias...";
        apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common figlet;
        figlet z3ta Tools 1.0
    echo "Passo 4 - Adicionando nova entrada ao repositorio...";
        curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -;
        add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable";
    echo "Passo 5 - Atualizando sistema...";
        apt-get update;
    echo "Passo 6 - Instalando Docker...";
        apt -y install docker-ce;
    echo "Passo 7 - Validando instalacao do Docker...";
        docker;
    #comando de atualização

    sleep 1 #aguardar 1 segundo depois exibe a mensagem abaixo
    echo "Configurações realizadas com sucesso!"
else
    echo "Sistema não configurado"
    sleep 2
fi

