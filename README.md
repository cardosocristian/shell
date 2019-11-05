# shell

Scripts em Shell para uso em serviços de rede.



# Blacklist.sh
Arquivo para criação e remoção de IP em uma lista chamada blacklist no serviço de firewall PF utilizado em sistemas BSD.

Para esse script funcionar, necessário ter no PF duas linhas

table < blacklist > persist

block in quick from < blacklist > 
