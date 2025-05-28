# Bloqueio Manual de Domínios com Script Bash

Este projeto tem como objetivo orientar **como bloquear domínios manualmente em uma máquina** Linux, utilizando ferramentas como `ufw`, `dig`, `cron` e edição do arquivo `/etc/hosts`.

> ⚠️ **Atenção:**  
> - Este procedimento **deve ser feito manualmente em cada máquina**.  
> - **Leia com atenção** antes de executar qualquer comando.  
> - **Linhas comentadas (em verde)** iniciadas com `#` **não devem ser copiadas/executadas** no terminal.

---

## Objetivo

Bloquear o acesso a domínios específicos (como o Facebook) em uma máquina Linux, por meio de:

- Regras de firewall (`ufw`)
- Redirecionamento de nomes via `/etc/hosts`
- Execução automatizada via `cron`

---

## Requisitos

- Sistema operacional Linux
- Acesso como `sudo`
- Ferramentas: `ufw`, `cron`, `dig` (disponível via `dnsutils`)

---

## Aviso Legal

Este projeto é fornecido **sem garantias**. Use **por sua conta e risco**. Alterações indevidas em regras de firewall e arquivos do sistema podem afetar o funcionamento da máquina.
