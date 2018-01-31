#!/bin/sh
# mysqlBackup.sh


# This is free and unencumbered software released into the public domain.

# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.

# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

# For more information, please refer to <http://unlicense.org/>


###########################################
#      Script de backup automatizado      #
#       Criado por Leandro S. Sousa       #
#             Data: 23/01/2017            #
# Pacotes necessarios para utilizacao:    #
#             *sendEmail                  #
#             *pv                         #
###########################################

# Antes de iniciarmos o processo de backup,
# sera necessario verificar se ha espaco 
# em disco para realizar a operacao.
# Para isso utilizaremos o codigo abaixo:

ESPACO=`df -h | awk '{print $5}' | grep -v Use | sort -nr | awk -F % '{print $1}' | head -n1`
ESPACO_INODE=`df -hi | awk '{print $5}'  | grep -v IUse | sort -nr | awk -F % '{print $1}' | head -n1`
ALERTA_RISCO="O disco esta prestes ficar sem espaco por favor verificar \n\n `df -h ` \n\n `ifconfig` \n\n `uname -a`"
ALERTA_CHEIO="O disco encheu verificar com urgencia \n\n `df -h ` \n\n `ifconfig`\n\n  `uname -a`"
ALERTA_RISCO_INODE="O disco esta prestes ficar sem espaco por favor verificar \n\n `df -hi ` \n\n `ifconfig` \n\n `uname -a`"
ALERTA_CHEIO_INODE="O disco encheu verificar com urgencia \n\n `df -hi ` \n\n `ifconfig`\n\n  `uname -a`"
SUBJECT_1="ESPACO EM DISCO PREOCUPANTE!"
SUBJECT_2="ESPACO EM DISCO ACABOU!"
SUBJECT_1_I="ESPACO EM DISCO PREOCUPANTE_INODE."
SUBJECT_2_I="ESPACO EM DISCO ACABOU_INODE."

EMAIL_DST="INFORME O ENDEREÇO IP DE DESTINO"
EMAIL_ORI="INFORME ENDEREÇO DE IP DE ORIGEM"
SERVER="INFORME EMAIL E PORTA DO SERVIDO EXE.: MAIL.GOOGLE.COM:587"

# Verifica espaco em disco
case $ESPACO in
        9[1-9])# Caso o disco esteja entre 91 a 99 ele manda um email avisando
        sendEmail -f $EMAIL_ORI -t $EMAIL_DST -u $SUBJECT_1 -m "$ALERTA_RISCO" -s $SERVER;;
        100)# Caso encha tb
        sendEmail -f $EMAIL_ORI -t $EMAIL_DST -u $SUBJECT_2 -m "$ALERTA_CHEIO"  -s $SERVER;;
esac

case $ESPACO_INODE in
        9[1-9])# Caso o disco esteja entre 91 a 99 ele manda um email avisando
        sendEmail -f $EMAIL_ORI -t $EMAIL_DST -u $SUBJECT_1_I -m "$ALERTA_RISCO_INODE" -s $SERVER;;
        100)# Caso encha tb
        sendEmail -f $EMAIL_ORI -t $EMAIL_DST -u $SUBJECT_2_I  -m "$ALERTA_CHEIO_INODE"  -s $SERVER;;
esac


# Caso esteja tudo OK, partiremos 
# para o processo de backup em si.
DATA=`/bin/date +%Y%m%d`

# NOME armazena o nome do arquivo de backup
ARQUIVO="backup_full_databases_$DATA.sql"

# Diretório de backup
DIRETORIO="/home/INFORME PERFIL DO USUARIO/Backup_banco/"


# Variáveis do MySQL
HOST="INFORME ENDEREÇO DO SERVIDOR"
USER="INFORME O LOGIN"
PASSWORD="INFORME A SENHA"
DATABASE="--all-databases"


# Configuracao do servidor SMTP
SMTP="INFORME O ENDEREÇO DO SERVIDOR:PORTA"
EMAIL="INFORME ENDEREÇO DE EMAIL DE CONEXÃO"
SENHA="INFORME A SENHA"
REMETENTE="INFORME EMAIL DO REMETENTE"
DESTINATARIO="INFORME EMAIL DO DESTINATARIO"


# Configurando limpeza automatica
export PATH="/bin:/sbin:/usr/bin:/usr/sbin" 
DIAS="5"
CMD="find $DIR -name "backup_*" -type d -ctime +$DIAS"
ARQ="/tmp/bkp_old.log"

#Verifica se arquivos com mais de 5 dias de criacao
$CMD &> $ARQ 2> /dev/null
AUX=$(cat $ARQ | wc -l)
if [ $AUX = 0 ]; then
	RESPOSTALIMPEZA="Nenhum backup com mais de $DIAS dia(s) para excluir! "
else
   $CMD | xargs rm -rf
   RESPOSTALIMPEZA="Backup(s) com mais de $DIAS dia(s) de criacao excluido(s)! "
   rm -rf $ARQ 
fi


echo "Iniciando processo de backup em "$DATA >> "/home/INFORME PERFIL DO USUARIO/Backup_banco/log_de_backup.txt"

# Primeiro sera verificado se existe arquivo com a mesma data dentro do diretorio
# Se existir o arquivo ele nao fara o backup
if [ -e "$DIRETORIO$ARQUIVO" ]; then
echo "O arquivo de backup ja existe" >> "/home/INFORME PERFIL DO USUARIO/Backup_banco/log_de_backup.txt"
echo "Fim do processo de backup." >> "/home/INFORME PERFIL DO USUARIO/Backup_banco/log_de_backup.txt"

# Se o arquivo nao existir, entao sera iniciaod o processo de backup
else
echo "Iniciando backup da base de dados..." >> "/home/INFORME PERFIL DO USUARIO/Backup_banco/log_de_backup.txt"
mysqldump -h $HOST -u $USER -p$PASSWORD $DATABASE | pv -s 4000M > $DIRETORIO$ARQUIVO

# Apos realizar o backup, o sistema retorna o tamanho do arquivo gerado.
TAMANHO=`du -h $DIRETORIO$ARQUIVO`

# Por fim, estas informacoes serao armazenadas no arquivo de log.
echo "Fim do processo de backup." >> "/home/INFORME PERFIL DO USUARIO/Backup_banco/log_de_backup.txt"
echo  $TAMANHO  >> "/home/INFORME PERFIL DO USUARIO/Backup_banco/log_de_backup.txt"


# Montando email para envio
ASSUNTO="Backup automatico base de dados Mysql"
MENSAGEM="Backup realizado com sucesso! O arquivo gerado foi $TAMANHO."

# Enviando email 
sendEmail -o tls=yes -f $REMETENTE -t $DESTINATARIO -s $SMTP -xu $EMAIL -xp $SENHA -u $ASSUNTO -m $RESPOSTALIMPEZA$MENSAGEM

fi
