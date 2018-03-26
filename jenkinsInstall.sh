#!/bin/bash
#autor: Leandro z3ta  
#Em caso de bugs enviar um email para
#email: leandroz3ta@gmail.com
#Jenkins Install 


echo "***********************************************************"
echo "*              Jenkins Install                            *"
echo "*                  Ver. 0.1.0                             *"
echo "***********************************************************"

echo "Você deseja realizar  a configuração do sistema?  Digite 1)Sim  0)Não"
read OPCAO #guarda opção inserida pelo usuário

if [ "$OPCAO" -eq 1 ]; then  #analisa a escolha digitada pelo usuário

  echo "Passo 1 - Efetuando downloads..."; 
  wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add;
	echo "Passo 2 - Gravando entrada no repositorio"; 
	echo "deb https://pkg.jenkins.io/debian-stable binary/" | sudo tee -a /etc/apt/sources.list;
	echo "Passo 3 - Executando atualização..."; 
	apt-get update; 
	echo "Passo 5 - Executando instalação do jenkins"; 
	apt-get install jenkins;
    #comando de atualização 
    
    sleep 1 #aguardar 1 segundo depois exibe a mensagem abaixo
    echo "Configurações realizadas com sucesso!"
else
    echo "Sistema não configurado"
    sleep 2
fi
