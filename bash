# ESTE FILE ORIENTA COMO BLOQUEAR DOMÍNIOS EM UMA MÁQUINA;
# ESTE PROCEDIMENTO DEVE SER FEITO MANUALMENTE EM CADA MÁQUINA;
# QUE DESEJAR BLOQUEAR ALGUM DOMÍNIO, *COM ATENÇÃO*.

# LINHAS VERDES COMO ESTA(COMENTADAS) NÃO DEVEM SER ADICIONADAS AOS COMANDOS NO BASH.

#Criar arquivo chamado bloquear-dominios
sudo nano /usr/local/bin/bloquear-dominios.sh

#!/bin/bash

DOMINIOS=("facebook.com" "www.facebook.com" "l.facebook.com" "connect.facebook.net")
PORTAS=("80" "443")

for DOMINIO in "${DOMINIOS[@]}"; do
    IPS=$(dig +short $DOMINIO | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')
    if [ -z "$IPS" ]; then
        continue
    fi
    for IP in $IPS; do
        for PORTA in "${PORTAS[@]}"; do
            RULE_EXISTS=$(sudo ufw status numbered | grep "$IP port $PORTA")
            if [ -z "$RULE_EXISTS" ]; then
                sudo ufw deny out to $IP port $PORTA proto tcp
            fi
        done
    done
done

#Criar executável
sudo chmod +x /usr/local/bin/desbloquear-dominios.sh

#Agendar com cron
sudo crontab -e
    #Adicionar ao final
    @hourly /usr/local/bin/bloquear-dominios.sh >> /var/log/bloqueio-dominios.log 2>&1


#Para rodar o script pela primeira vez
sudo /usr/local/bin/bloquear-dominios.sh

#Verificar se regras foram aplicadas
sudo ufw status numbered

#Ativar UFW
sudo ufw enable

#Confirmar se os IPs bloquados correspondem
dig +short facebook.com
dig +short www.facebook.com
sudo ufw status numbered

#Adicionar bloqueio por nome no /etc/hosts
sudo nano /etc/hosts
#Adicionar ao final
    127.0.0.1 facebook.com
    127.0.0.1 www.facebook.com
    127.0.0.1 l.facebook.com
    127.0.0.1 connect.facebook.net

