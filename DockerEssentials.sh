#!/bin/sh
#autor: Leandro z3ta
#Em caso de bugs enviar um email para
#email: leandroz3ta@gmail.com
#Docker Essentials 1.0

figlet Docker Essentials Image v. 1.0

echo "Selecione o tipo de ambiente a ser instalado:";
echo "1) Ambiente web.";
echo "2) Ambiente de testes automatizados.";
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
	9)
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
