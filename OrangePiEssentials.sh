#!/bin/bash
#autor: Leandro z3ta
#Em caso de bugs enviar um email para
#email: leandroz3ta@gmail.com
#Orange Pi Essentials


echo "***********************************************************"
echo "*              Orange pi Essentials                       *"
echo "*                  Ver. 0.1.0                             *"
echo "***********************************************************"

echo "Você deseja realizar  a configuração do sistema?  Digite 1)Sim  0)Não"
read OPCAO #guarda opção inserida pelo usuário

if [ "$OPCAO" -eq 1 ]; then  #analisa a escolha digitada pelo usuário

    echo "preparando pacotes basicos do ambiente...";
    apt-get update;
    apt-get install nano;
    apt-get install wpa_supplicant;
    echo "Pacotes basicos instalados.";
    
    echo "Deseja instalar sistema na memoria interna?"
    read OPCAOMEMORIA
    if [ "$OPCAOMEMORIA" -eq 1]; then
        
        echo "Instalando sistema na memoria interna do dispositivo...";
        nand-sata-install;
    fi
    echo "Passo 1 - Iniciando upgrade do sistema...";
        apt-get update;
        apt-get upgrade;
        echo "Passo 2 - Instalando pacotes essenciais...";
        echo "Instalando pacotes I2c..."
        apt-get install python-smbus python-dev;
        apt-get install i2c-tools;
        echo "Habilitando i2c...";
        echo "i2c-dev" >> /etc/modules;
        echo "Adicinando user I2c...";
        adduser pi i2c;
        echo "Reiniciando sistema...";
        reboot;
    #comando de atualização

    sleep 1 #aguardar 1 segundo depois exibe a mensagem abaixo
    echo "Configurações realizadas com sucesso!"
else
    echo "Sistema não configurado";
    sleep 2;
fi
