#!/bin/sh

echo "Selecione uma das opcoes abaixo:";
echo "1) Instalacao pacotes basicos de ambiente.";
echo "2) Instalacao instalar sistema na memoria interna.";
echo "3) Habilitar acesso serial via OTG.";
echo "4) Instalacao pacotes I2c.";
echo "0) Finalizar assistende de conficuracao";
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
		echo "Digite 0 para sair ou 9 para menu Inicial.";
		;;
	2)
    		echo "Instalando sistema na memoria interna do dispositivo...";
    		nand-sata-install;
		echo "Digite 0 para sair ou 9 para menu Inicial.";
		;;
	3)
		echo "Habilitando entrada g_serial no arquivo modules..."
		echo "g_serial" >> /etc/modules;
		echo "Criando diretorios necessarios...";
		mkdir -p /etc/systemd/system/serial-getty@ttyGS0.service.d;
		echo "Copiando arquivos...";
		cp 10-switch-role.conf /etc/systemd/system/serial-getty@ttyGS0.service.d;
		echo "Finalizando a instalcacao..."
		systemctl --no-reload enable serial-getty@ttyGS0.service;
		echo "ttyGS0" >> /etc/securetty;
		echo "Reiniciando dispositivo..."
		reboot;
		;;
	4)
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
	9)
		echo "Selecione uma das opcoes abaixo:";
		echo "1) Instalacao pacotes basicos de ambiente.";
		echo "2) Instalacao instalar sistema na memoria interna.";
		echo "3) Habilitar acesso serial via OTG.";
		echo "4) Instalacao pacotes I2c.";
		echo "0) Finalizar assistende de conficuracao";
		;;
	0)
		echo "Ate logo! =)"
		break
		;;
	*)
		echo "Opcao invalida!"
		echo "Digite 0 para sair ou 9 para menu Inicial.";
		;;
  esac
done
echo 
echo "Fim."
