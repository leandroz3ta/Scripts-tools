#!/bin/sh
#autor: Leandro z3ta
#Em caso de bugs enviar um email para
#email: leandroz3ta@gmail.com
#Docker Essentials 1.0

figlet Docker Essentials Image v. 1.0

echo "Selecione o tipo de ambiente a ser instalado:";
echo "1) Ambiente web.";
echo "2) Ambiente de testes automatizados.";
echo "3) Comandos basicos.";
echo "0) Finalizar assistende de conficuracao";
while :
do
  read INPUT_STRING
  case $INPUT_STRING in
	1)
		echo "iniciando download da imagem...";
    docker run --name myXampp -p 41061:22 -p 41062:80 -d -v ~/my_web_pages:/www tomsik68/xampp;
    echo "Imagem instalada com sucesso!";
		echo "Digite 0 para sair ou 9 para menu Inicial.";
		;;
	2)
    echo "iniciando download da imagem...";
    docker run -p 8080:8080 -p 50000:50000 jenkins;
    echo "Imagem instalada com sucesso!";
		echo "Digite 0 para sair ou 9 para menu Inicial.";
		;;
	3)
    echo "docker images";
    echo "docker rm ID_ou_nome_do_container - Remove o container solicitado";
    echo "docker rmi ID_ou_nome_da_imagem - Remove a imagem solicitada";
    echo "docker run nome_da_imagem - Instala container a partir da imagem informada";
    echo "docker run --name ubuntinho ubuntu - Instala o container e o apelida";
    echo "docker run -it ubuntu /bin/bash - Instala o container e loga no terminal";
    echo "docker ps -a - Lista todos os containers";
		echo "Digite 0 para sair ou 9 para menu Inicial.";
		;;
	9)
	clear
    	figlet Docker Essentials Image v. 1.0

    echo "Selecione o tipo de ambiente a ser instalado:";
    echo "1) Ambiente web.";
    echo "2) Ambiente de testes automatizados.";
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
