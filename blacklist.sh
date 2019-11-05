#!/usr/local/bin/bash


pfctl="/sbin/pfctl"

echo "INSERCAO OU REMOCAO DE BLACKLIST DE IP's"
echo " "
echo "Você deseja inserir um IP na blacklist ou remover?"
echo "Digite 1 para inserir e 2 para remover"
read opcao

        case $opcao in
                1) echo "Digite o IPv4 ou IPv6 que deseja inserir na blacklist"
                read IP
                
                #Lista IP's da tabela e joga em um arquivo
                /sbin/pfctl -t blacklist -T show > /root/blacklist.txt
                
                #Lista IP's da tabela e joga em um arquivo
                grep $IP /root/blacklist.txt

                if [ $? == 0 ]; then
                        echo "IP já está na blacklist"

                else
                         echo "Inserindo $IP na blacklist"
                        /sbin/pfctl -t blacklist -T add $IP
                        
                        #Caso o IP ja esteja com estado criado no kernel, mata os estado para ja dropar a conexao
                        /sbin/pfctl -k $IP 2>&-

                fi
                ;;

                2) echo "Digite o IPv4 ou IPv6 que deseja remover da blacklist"
                read IP
                
                #Lista IP's da tabela e joga em um arquivo
                /sbin/pfctl -t blacklist -T show > /root/blacklist.txt
                
                #Lista IP's da tabela e joga em um arquivo
                grep $IP /root/blacklist.txt

                if [ $? == 0 ]; then
                        echo "Removendo o $IP"
                        /sbin/pfctl -t blacklist -T delete $IP
                else
                        echo "$IP não esta na blacklist"
                fi

                ;;


                3) echo "Exibindo a tabela na tela"
                        /sbin/pfctl -t blacklist -T show
                ;;

        *)
        echo "Voltando ao menu anterior"

esac
~
