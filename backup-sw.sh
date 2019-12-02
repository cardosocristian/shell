#!/bin/bash

# Script onde geramos um array dos IP's dos switches da rede.
# A estrutura de diretórios do backup e em "/backup/dia", entao por isso
# utilizo a variavel $DIA, que retorna a data em ingles(Mon,Tue,etc).
# Com isso executo um for que percorre o array, acessando os switches via ssh e gerando
# um arquivo do tipo ".cfg" para em caso de disaster recovery, so sera necessario inserir no hardware e 
# iniciar novamente o switch, ou apenas dar um cat no backup e copiar e colar no terminal, caso seja esse o caso.
#
# Necessario ter instalado no servidor o comando sshpass para funcionamento do script



SW[0]="192.168.10.1"
SW[1]="192.168.10.2"
SW[2]="192.168.10.3"
SW[3]="192.168.10.4"

DIA=`date | awk {'print $1'}`
DIR='/backup/'

for i in `echo ${!SW[*]}`;do

sshpass -p minhasenha ssh usuario@${SW[$i]} "show running-config" > $DIR$DIA/${SW[$i]}.cfg
done
