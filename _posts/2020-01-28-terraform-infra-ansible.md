---
layout: post
title: "Voando nas nuvens"
subtitle: "Infraestrutura como código"
bigimg: /img/goku.gif
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
< blockquote class="twitter-tweet" data-theme="light"><p lang="pt" dir="ltr"></p>&mdash; Adelmo Filho (@AdelmoFilho42) <a href="https://twitter.com/AdelmoFilho42/status/1216443720544944136?ref_src=twsrc%5Etfw">January 12, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 
</center>

<br>

## Infrastructure as a Code

Quando encaramos a construção e configuração da nossa infraestrutura de processamento (e.b. computadores) como um código, passamos a ter um menor custo (tempo, dinheiro), menor risco de erros humanos e podemos versionar nossos códigos para melhor rastreabilidade de erros e colaboração com parceiros.

Só vantagens para o desenvolvedor.

Existem diferentes linguagens, ferramentas para trabalharmos com IaaC. Direcionadas para uma cloud especifica ou multi-cloud; declarativas ou imperativas...

Vale apena explorar as alternativas. Se tiver interesse no tema, experimente o livro do Kief Morris - [Infrastructure as Code](http://shop.oreilly.com/product/0636920039297.do)

Aqui, vamos focar em duas ferramentas complementares: Terraform e Ansible.

### Terraform

Terraform é um software de código aberto para gerenciamento de Infra as a Code que utiliza de línguagem proprietária (HCL) para comunicação com as APIs das provedoras de Cloud.

<center>
<img src="/img/terraform.png" style="display: block; margin: auto;height: 80px;">
</center>

Duas características fazem o Terraform ser uma opção interssante pra sua IaaC.

Primeiro, antes de enviar requisições à API da cloud, Terraform  cria um plano de execução que permite verificar todos os recursos e/ou modificações necessárias na sua infraestrutura. 

O plano ainda conta um grafo de depedência das alterações necessárias, o que permite a paralelização de atividades.

Somado a isso, para realizar modificações numa infra já existente não é necessariamente obrigatório reconstruir ela do zero. 

As execuções criam um arquivo (.tfstate) que armazena os recursos, configurações e metadados da infra criada pelo Terraform. 

Caso tenha, interesse o [material introdutório do Terraform](https://www.terraform.io/intro/index.html) é um bom ponto de partida.

### Ansible

Ansible é uma ferramenta de provisionamento de software. De forma curta, ele é capaz de acessar uma máquina já existente via SSH e promover a instalação e configuração de softwares. 

<center>
<img src="/img/ansible.png" style="display: block; margin: auto;height: 80px;">
</center>

As chamadas *tasks* que ele executará devem estar contidas em arquivos .yaml, denominados `playbooks`. 

Nos playbooks declaramos as instações desejadas, não como uma linha de comando, mas utilizando módulos do proprio Ansible. 

Se quisermos, por exemplo, instalar o python via apt, bastaria adicionar as seguintes linhas em um playbook.

```
- name: Install python
  apt:
    name: python
```

Além de tornar o trabalho de provisionamento automatizado, Ansible é escalável. 

Ao definir as ações em cada playbook, também somos capazes de referênciar em qual máquina ou grupo de máquinas queremos aplicar cada *task* do playbook. 

Isto é possível pelo Ansible trabalhar com o conceito de `inventários`.

```
[master]
127.0.0.1
bar.example.com

[workers]
one.example.com
two.example.com
```
<center>
<p align="center">Exemplo de inventário</p>
</center>

O inventário é um arquivo contendo o endereço das máquinas que terão provisionamento realizado pelo Ansible. 

Nos headers do aquivo temos a denominação que daremos para aplicar uma certa instrução àquelas máquinas.

Para aplicar a instrução de instalação do python apenas nas máquinas `workers` e de instalação do docker nas máquinas `master`, podemos escrever o seguinte playbook.

```
- hosts: master
  become: yes
  tasks:
    - name: install Docker  
      apt:
        name: docker.io

- hosts: workers
  become: yes
  tasks:
    - name: install python  
      apt:
        name: python

```

Caso se interesse pelo tema, recomendo o livro [Ansible for DevOps](https://.www.ansiblefordevops.com)


## Dirty Deeds Done Dirt Cheap (D4C)

Quando procurei um nome pra esse projeto, não esperava algo tão alinhado com seu propósito.

Sua referência pode ser AC/DC ou JoJo Bizarre Adventures, no fim, o que queremos é fazer algo entediante da forma mais ráṕida.

O `D4C` se propõe a criar um instância de tamanho e distribuição personalizavel usando a Digital Ocean como provedora de Cloud. No processo também é criada uma chave de acesso ssh para conexão.

Após criada a instância, o ansible realiza o provisionamento, configurando o firewall via `ufw`, levantando proteção contra ataques via `fail2ban` e impedindo o acesso via root. 

Finalmente, `docker` é instalado para que as aplicações deployadas no servidor sejam na forma de containers.

Para entrarmos em maiores detalhes, vejamos a árvore de arquivos e diretórios do projeto.

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

Com o módulo `provider` possibilitamos a comunicação do terraform com as API da cloud. 

Os módulos `resource` se referem a tudo que iremos criar de forma transparente na DIgital Ocean. A `digitalocean_droplet` se refere às instàncias de máquina virtual que desejamos, referenciamos ela com o nome "droplet".

No módulo de `connection`, definimos o tipo de acesso, usuário, e outros parâmetros de conexão com a droplet.

Nos módulos de `provisioner`, temos uma distinção do provisionamento executado de dentro da instância (remote-exec) e aquele executado pela máquina local (local-exec).

Apesar dos playbooks em ansible permitirem executar os comandos que estão no provisionamento remoto, adicionamos um provisionamento remoto para garantir que o `local-exec` só seja executado com a instância já criada.

Observe que o `main.tf` é completamente parametrizado. O valor assumido pelas variáveis utilizadas estão contidos nos arquivos `keys.tfvars`, `project.tfvars` e `provider.tfvars`. 

Desses arquivos, o `provider.tfvars` é um lista contendo as opções diponíveis pela API da Digital Ocean para cada recurso. Use o `keys.tfvars` para adicionar seu API token e personalize o arquivo `project.tfvars` com informações do seu projeto.

Não recomendo alterar qualquer outro arquivo, exceto se desejar adicionar alguma funcionalidade adicional. 

Conforme o `README` disponibilizado, personalize os arquivos `.tfvars` comentados acima, e execute os arquivos .sh para ter sua instância pronta para uso em poucos minutos.

## Devaneios finais

Foi um projeto bem divertido! 

Me esforcei em comentar todos os códigos, e tornar a operacionalização bem transparente.

Deu tão certo para mim, que uso o servidor criado pelo `D4C` para o deploy de minhas aplicações.

Espero que possa ser útil a você também!