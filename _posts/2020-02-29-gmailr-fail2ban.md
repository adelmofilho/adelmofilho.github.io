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

