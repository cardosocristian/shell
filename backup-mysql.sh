#!/usr/bin/env bash

date=$(date +%d%m%Y_%H-%M)

## Backup mysql zabbix

echo "Backup iniciando em $date " >> /var/log/backup.log

#Dump da base do zabbix
if $(mysqldump --set-gtid-purged=OFF zabbix > /backup/zabbix.sql); then
        echo "Backup mysql executado em $date" >> /var/log/backup.log

else
        # Se nao executar o dump informa no log e sai
        echo "Backup com erro, VERIFICAR!" >> /var/log/backup.log
        exit 1
fi

# Se ocorreu dump, efetua a compactacao
if $(tar cvJf /backup/backup-zabbix-"$date".xz /backup/zabbix.sql 2>&-); then
        echo "Compactacao em xz concluida e backup finalizado em $date" >> /var/log/backup.log
else
        # Se nao conseguiu fazer o tar informa no log
        echo "Compactacao com erro, VERIFICAR!" >> /var/log/backup.log
fi