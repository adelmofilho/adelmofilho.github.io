---
layout: post
title: "Voando nas nuvens"
subtitle: "Acelerando seus estudos com IaaC"
bigimg: /img/iaac.jpeg
tags: [cloud, terraform, iaac, ansible, digital-ocean]
comments: true
draft: true
output:
  html_document:
    keep_md: true
---

Was a long and dark December... Anos atrás...

Acessei meu servidor, e quando fui conferir o status de um banco de dados me deparei com a mensagem:

> Send us 0.5 BTC to recover your database

Aquele vixe, atrás de eita.

Por pior que tenha sido ser hackeado, no futuro isso me faria estudar mais sobre segurança e a comprar bitcoins (isso não foi tão bom).

Apesar do susto, estava tranquilo, pois tinha comigo meu bloco de notas com os comandos para recuperar o servidor do zero.

Um bloco de notas com os comandos para recuperar o servidor do zero...

Um bloco de notas...

<center>
<img src="/img/pocoyo.jpg" style="display: block; margin: auto;height: 220px;">
</center>

<p align="center">O importante é a gente ir evoluindo, né?</p>

Não nego que, nesses anos, até foi divertido subir na unha um cluster spark, mapear cada porta do hadoop, resolver os bugs de colocar um servidor R-shiny num raspberry. 

Mas, ter que refazer todo o processo duas, três vezes por ter bloqueado meu próprio ip, já era demais.

Todo esse ciclo mudou quando conheci as ferramentas de Infra as a Code (IaaC).

Neste post, quero compartilhar um projeto recente que escrevi para por um ponto final nesta trabalheira de subir e derrubar máquinas na cloud.

## Tl;dr

O projeto `Dirty Deeds Done Dirt Cheap` disponibiliza um conjunto de scripts em terraform e ansible para criação de instâncias na cloud da Digital Ocean.

A ideia é reduzir o desgaste gerado na configuração dessas máquinas, já disponibilizando ferramentas de segurança e ambiente para prototipagem com docker.

Todas as instruções para operacionalização do projeto estão em seu `README`. 

<center>
<blockquote class="twitter-tweet" data-theme="light"><p lang="pt" dir="ltr"></p>&mdash; Adelmo Filho (@AdelmoFilho42) <a href="https://twitter.com/AdelmoFilho42/status/1216443720544944136?ref_src=twsrc%5Etfw">January 12, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 
</center>

<br>

## Infrastructure as a Code

Quando encaramos a construção e configuração da nossa infraestrutura de processamento (e.b. computadores) como um código, passamos a ter um menor custo (tempo, dinheiro), menor risco de erros humanos e podemos versionar nossos códigos para melhor rastreabilidade de erros e colaboração com parceiros.

Só vantagens para o desenvolvedor.

Existem diferentes linguagens, ferramentas para trabalharmos com IaaC. Direcionadas para uma cloud especifica ou multi-cloud; serverless ou com arquitetura cliente-servidor; declarativas ou imperativas.

Vale apena explorar as alternativas, se tiver interesse no tema.

Aqui, vamos focar em duas opções complementares: terraform e ansible.

### Terraform


### Ansible


## Dirty Deeds Done Dirt Cheap (D4C)

Quando procurei um nome pra esse projeto, não esperava algo tão alinhado com seu propósito.

Sua referência pode ser AC/DC ou JoJo Bizarre Adventures, no fim, o que queremos, é fazer algo entediante da forma mais ráṕida.

O `D4C` se propõe a criar um instância de tamanho e distribuição usando a Digital Ocean como provedora de Cloud. No processo também é criada uma chave de acesso ssh para conexão.

Após criada a instância, o ansible realiza o provisionamento, configurando o firewall via `ufw` e levantando proteção contra ataques via `fail2ban` e impedindo o acesso via root. 

Finalmente, `docker` é instalado para que as aplicações deployadas no servidor sejam na forma de containers.

Para entrarmos em maiores detalhes, confira, primeiro, a árvore de arquivos e diretórios do projeto.

```
.
├── ansible/
│   ├── jail.local
│   ├── provision.yml
│   └── sshd_config
├── connect.sh
├── create.sh
├── credentials/
│   ├── id_rsa
│   └── id_rsa.pub
├── destroy.sh
├── setup.sh
└── terraform/
    ├── env/
    │   ├── keys.tfvars
    │   ├── project.tfvars
    │   └── provider.tfvars
    ├── main.tf
    ├── out/
    ├── outputs.tf
    └── variables.tf

```

O arquivo `main.tf` é o coração do projeto. Além de criar a instância e as chaves ssh, é ele que executa o playbook de ansible para o posterior provisionamento de recursos.

<script src="https://gist.github.com/adelmofilho/10893f684fae9de72b3615b161d2497d.js"></script>


<br>