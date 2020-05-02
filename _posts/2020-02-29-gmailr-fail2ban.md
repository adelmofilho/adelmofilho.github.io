---
layout: post
title: "Fail2Ban"
subtitle: "Uma análise descritiva das tentativas de ataque ao meu servidor"
bigimg: /img/hs.gif
tags: [r, 'gmailr', 'fail2ban', 'webscrapping']
comments: true
draft: true
output:
  html_document:
    keep_md: true
---

> Comunidade, parabéns pelos 20 anos da versão v1.0.0 do R !!!

A internet não é um lugar seguro.

Se já não bastasse a quantidade de arquivos maliciosos escondidos em banners e fake news sendo disseminadas, vivemos sob constantes tentativas de invasão.

As invasões podem ocorrer com diferentes abordagens: Tentativas de invasão a clientes de email e redes sociais, uso do cartão de crédito em e-commerces etc.

Mas, quem tem um servidor na nuvem (AWS, DigitalOcean, GCP) sabe a guerra que é manter segura um máquina com IP público.

Chega a ser comum receber dezenas de ataques de força bruta por dia. 

Em geral, serviços automatizados que buscam encontrar alguma vunerabilidade nas portas expostas ou tentam se conectar via SSH ao servidor sem serem convidados.

Para nos protegermos, podemos utilizar diversas estrategias. Desde parametrizar configurações da conexão via SSH (e.g. desabilitar acesso root) até utilizar firewall e softwares de proteção.

O `fail2ban` é um desses softwares. 

Além de conversar com SSH, também pode ser configurado para Apache, FTP, MTA. 

Ele permite criar regras para "banir" o acesso de um IP específico caso ele realize um número de tentativas de acesso incorretas dentro de um periodo de tempo.

Durante algumas meses, parametrizei o `fail2ban` da forma mais restritiva possível e habilitei um envio de e-mail para cada tentativa de invasão.

Vamos analisar os dados destes e-mails agora!

## Extração de dados

Todos os e-mails enviados pelo `fail2ban` tem formato semelhante ao apresentado a seguir. As diferenças estão no conteúdo e na adição ou remoção de algum dos campos listados.

```
De: Fail2Ban <Fail2BanAlerts@black-scaled-earth-dragon.com>
Date: dom., 2 de jun. de 2019 às 06:07
Subject: [Fail2Ban] sshd: banned 197.227.110.85 from Black-Scaled-Earth-Dragon.com
To: <adelmo.aguiar.filho@gmail.com>


Hi,

The IP 197.227.110.85 has just been banned by Fail2Ban after
2 attempts against sshd.


Here is more information about 197.227.110.85 :

% This is the AfriNIC Whois server.

% Note: this output has been filtered.
%       To receive output for a database update, use the "-B" flag.

% Information related to '197.226.0.0 - 197.227.255.255'

% No abuse contact registered for 197.226.0.0 - 197.227.255.255

inetnum:        197.226.0.0 - 197.227.255.255
netname:        MauritiusTelecom
descr:          MauritiusTelecom
country:        MU
admin-c:        YR6-AFRINIC
tech-c:         JL279-AFRINIC
status:         ASSIGNED PA
remarks:        MauritiusTelecom
mnt-by:         MU-TELECOMPLUS-MNT
source:         AFRINIC # Filtered
parent:         197.224.0.0 - 197.227.255.255

person:         Johnny Lim Fook
address:        7th Floor
address:        Telecom Tower
address:        Edith Cavell Street
address:        Port Louis
address:        Mauritius
phone:          tel:+230-213-4106
fax-no:         tel:+230-212-8290
nic-hdl:        JL279-AFRINIC
mnt-by:         MU-TELECOMPLUS-MNT
source:         AFRINIC # Filtered

person:         Yagianath Rosunee
address:        6th Floor Edith Cavell St
address:        Port Louis
address:        MAURITIUS
phone:          tel:+230-203-7014
fax-no:         tel:+230-211-8888
nic-hdl:        YR6-AFRINIC
mnt-by:         MU-TELECOMPLUS-MNT
source:         AFRINIC # Filtered


Lines containing failures of 197.227.110.85
Jun  2 09:07:17 Black-Scaled-Earth-Dragon sshd[4837]: Invalid user pi from 197.227.110.85 port 33438
Jun  2 09:07:18 Black-Scaled-Earth-Dragon sshd[4837]: Connection closed by invalid user pi 197.227.110.85 port 33438 [preauth]
Jun  2 09:07:18 Black-Scaled-Earth-Dragon sshd[4839]: Invalid user pi from 197.227.110.85 port 54558
Jun  2 09:07:18 Black-Scaled-Earth-Dragon sshd[4839]: Connection closed by invalid user pi 197.227.110.85 port 54558 [preauth]


Regards,

Fail2Ban
```

No exemplo acima, `Black-Scaled-Earth-Dragon` é o nome do meu servidor. Nele, temos informações do IP do invasor, local, horário e porta utilizada na tentativa de invasão.

Para automatizar as mais de 8000 mensagens de tentativas de invasão, utilizei o pacote R `{gmailr}`, um cliente para API do Gmail.

### Habilitando o gmailR

Após instalar o pacote `{gmailR}` é necessário obter credenciais válidas para sua conta de e-mail. Conforme, documentação do pacote, a forma mais prática é utilizando o [Quickstart da Google](https://developers.google.com/gmail/api/quickstart/python).

Clique no botão `Enable the Gmail API` para fazer o download de um arquivo `.json` com as credenciais de sua conta.

![](./img/quick.png)

Em seguida, utilize a função `gm_auth_configure` informando o local (`path`) onde estão as credenciais.

```
gmailr::gm_auth_configure(path = "credentials/credentials.json")
```

Uma mensagem surgirá no console pedindo para confirmar o e-mail associado às credenciais. Aceite a opção informada.

### Obtendo a ID das mensagens

A forma de extrairmos 
