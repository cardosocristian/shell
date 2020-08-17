#!/usr/local/bin/bash


pfctl="/sbin/pfctl"

echo "INSERCAO OU REMOCAO DE BLACKLIST DE IP's"
echo "Você deseja inserir um IP na blacklist ou remover?"
read -p "| Digite 1 para inserir| Digite 2 para remocao | 3 para exibicao da lista de IP's | Opcao: " opcao

        case $opcao in
                1) echo "Digite o IPv4 ou IPv6 que deseja inserir na blacklist"
                read IP
                
                #Lista IP's da tabela e joga em um arquivo, já que em caso de reiniciar nao mantem os IP's bloqueados na memória
                #assim recarregamos os IP's na lista ao reiniciar o roteador
                $pfctl -t blacklist -T show > /root/blacklist.txt
                
                
                #Verifica se o IP não está na lista
                if /sbin/pfctl -t blacklist -T show | grep "$IP"; then

                        echo "IP já está na blacklist"

                else

                        echo "Inserindo IP na blacklist"
                        /sbin/pfctl -t blacklist -T add $IP
                        
                        #Caso o IP ja esteja com estado criado no kernel, mata os estados para ja dropar a conexao
                        /sbin/pfctl -k $IP 2>&-

                fi
                ;;

                2) echo "Digite o IPv4 ou IPv6 que deseja remover da blacklist"
                read IP

          		#Verifica se o IP esta na lista
                if $pfctl -t blacklist -T show | grep "$IP"; then

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
