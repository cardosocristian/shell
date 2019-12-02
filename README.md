# shell

Scripts em Shell para uso em serviços de rede.

# Backup-sw.sh

Arquivo para backup de switches que tenham liberado o acesso via SSH.


# Blacklist.sh
Arquivo para criação e remoção de IP em uma lista chamada blacklist no serviço de firewall PF utilizado em sistemas BSD.

Para esse script funcionar, necessário ter no PF duas linhas

table < blacklist > persist

block in quick from < blacklist > 
