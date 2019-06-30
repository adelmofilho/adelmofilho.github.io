---
layout: post
title: "Criando seu bot no Telegram com Docker"
subtitle: "Telegram não é só pra vazar mensagem"
bigimg: /img/docker.gif
tags: [r, rstudio, infra, hadoop, spark]
comments: true
draft: true
output:
  html_document:
    keep_md: true
---

Eu tô muito feliz!

Meses postergando estudar [docker](https://en.wikipedia.org/wiki/Docker_(software)), finalmente risquei essa tarefa do meu to-do.

Nesse post quero abordar a criação de um container em docker para hospedar um [bot telegram](https://core.telegram.org/bots).

Vamos utilizar o pacote `telegram.bot` do R para isso!

## O que é docker?

Extraindo direto da Wikipédia, temos que:

> Docker is a set of coupled software-as-a-service and platform-as-a-service products that use operating-system-level virtualization to develop and deliver software in packages called containers.

Ao passo que container são definidos como:

> Containers are (software in packages) isolated from each other and bundle their own software, libraries and configuration files; they can communicate with each other through well-defined channels. All containers are run by a single operating-system kernel and are thus more lightweight than virtual machines. 

Em outras palavras, a ideia do docker é compartimentar uma virtualização do sistema operacional contendo apenas as depedências (bibliotecas, configurações) necessárias para entregar determinado produto (API, serviço, ambiente).

Na época que li sobre Docker, minha grande dúvida não era o "o que é?", mas "por quê?"

## Por quê Docker?

Imagine, você acordar certo dia e instalar um pacote/biblioteca/programa e verificar que algo deixou de funcionar como deveria.

Não faltam exemplos:

- Atualizar a versão do java e ver o pacote [`rjava` dolorosamente quebrando](https://www.r-statistics.com/2012/08/how-to-load-the-rjava-package-after-the-error-java_home-cannot-be-determined-from-the-registry/)

- Atualizar a versão do R para a 3.6.0 e ver que [o método `runif()` não retorna mais os mesmos números para mesma seed](https://blog.revolutionanalytics.com/2019/05/whats-new-in-r-360.html)

- Atualizar a versão do R para a 3.6.0 e [descobrir que é necessário adaptar a leitura dos .rds de versões anteriores](https://blog.revolutionanalytics.com/2019/05/whats-new-in-r-360.html) - imagina o susto de não conseguir abrir os resultados de sua pesquisa.

- Atualizar algum pacote e descobrir que determinada função não existe ou não opera mais como antigamente (saudade `devtools`)

Caso usassemos docker, estas situações seriam sanadas, pois cada análise/produto estaria sendo realizada em um ambiente personalizado sem conflito com a necessidade das outras análises/produtos.

Na linguagem do docker, esse ambiente é uma `imagem` - representada por um arquivo (`dockerfile`) que tem as instruções para criar o ambiente do zero (do kernel do sistema operacional para ser mais específico).

## Esticando as mangas

Os próximos passos supõem que você tem acesso [`sudo`](https://en.wikipedia.org/wiki/Sudo) a uma máquina linux com Ubuntu 18 instalado.

Caso você não tenha, ou não tenha ideia do que estou falando, acesse os seguintes documentos de referência:

- [How to Create a Droplet from the DigitalOcean Control Panel](https://www.digitalocean.com/docs/droplets/how-to/create/)

- [Initial Server Setup with Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-18-04)

As referências são voltadas para os serviços da [DigitalOcean](https://www.digitalocean.com/), mas na prática caso deseje usar as instâncias linux da AWS ou Google Cloud - it´s up to you.

### Instalando o Docker

Acesse seu terminal linux e atualize seus repositórios inicialmente:

```
sudo apt-get update && sudo apt-get upgrade
```

Removemos qualquer instalação prévia do docker com o seguinte comando:

```
sudo apt-get remove docker docker-engine docker.io
```

Em seguida, instalamos e ativamos o docker em nossas máquinas:

```
sudo apt install docker.io

sudo systemctl start docker
sudo systemctl enable docker
```

Vamos agora criar nossa primeira imagem docker.

### Criando uma imagem Docker



```
cd
mkdir bot
```



bot.R
.Renviron
dockerfile



https://github.com/ebeneditos/telegram.bot/wiki/Building-an-R-Bot-in-3-steps