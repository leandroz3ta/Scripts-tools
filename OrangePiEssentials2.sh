#!/bin/sh

echo "Selecione uma das opcoes abaixo:";
echo "1) Instalacao pacotes basicos de ambiente.";
echo "2) Instalacao instalar sistema na memoria interna.";
echo "3) Instalacao pacotes I2c.
while :
do
  read INPUT_STRING
  case $INPUT_STRING in
	1)
		apt-get update;
    		apt-get upgrade;
    		apt-get install nano;
    		apt-get install wpa_supplicant;
    		echo "Pacotes basicos instalados.";
		;;
	2)
    		echo "Instalando sistema na memoria interna do dispositivo...";
    		nand-sata-install;
		;;
	3)
		echo "Instalando pacotes I2c..."
		apt-get install -y python-smbus python-dev;
		apt-get install -y i2c-tools;
		echo "Habilitando i2c...";
		echo "i2c-dev" >> /etc/modules;
		echo "Adicinando user I2c...";
		adduser orangepi i2c;
		echo "Reiniciando sistema...";
		reboot;
		;;
	*)
		echo "Opcao invalida!"
		;;
  esac
done
echo 
echo "Fim."
