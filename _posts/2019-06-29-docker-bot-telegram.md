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

### Montando nosso bot no Telegram

Primeiramente, baixe o Telegram na playstore de seu celular.

Eu também recomendo instalar o Telegram Desktop.

Para ambos os casos, entre em contato com o [@botfather](https://telegram.me/botfather) - o bot dos bots.

Aquele que fornece para você sua chave de acesso (token) para controle de um novo bot.


Ao acessar o chat do @botfather, uma série de opções e comandos se abrirão.

<p><img src="https://i.imgur.com/ZzKwp7Z.png" alt="@botfather initial chat" align="center"></p>

Escreva `/newbot` e responda as perguntas conformem forem aparecendo para ter acesso ao seu token:

<p><img src="https://i.imgur.com/8WMa8kU.png" alt="@botfather initial chat" align="center"></p>

A partir desse momento nosso bot existe mas não possui qualquer comando associado a ele.

No caso acima, o bot poderá ser encontrado pela @botAF_mangabot e seu nome de usuário será mangabot.

### Dando inteligência ao bot

Para ilustrar a orquestração do bot via pacote `telegram.bot` vamos criar um script R com a função básica de todo bot: `/start`.

Em seu terminal linux, crie uma pasta `bot` - ou qualquer outro nome de interesse - e a acesse:

```
cd
mkdir bot
cd bot/
```

Crie os arquivos `bot.R` (orquestrador do bot) e `.Renviron` (arquivo que armazenará o token):

```
touch bot.R
touch .Renviron
```

Edite o arquivo `bot.R`, com seu editor de preferência, inserindo o seguinte código:

```
library(telegram.bot)

start <- function(bot, update) {
  bot$sendMessage(
    chat_id = update$message$chat$id,
    text = sprintf("Hello %s!", update$message$from$first_name)
  )
}

updater <- Updater(token = bot_token("botname")) + CommandHandler("start", start)

updater$start_polling()
```

Uma vez que estiver rodando, o bot retornará "hello nome_da_pessoa" quando for escrito `/start`.

Esse código e muitos outros templates podem ser encontrados no [github do pacote telegram.bot](https://github.com/ebeneditos/telegram.bot)

Os detalhes de como construir estas funções e a operacionalização do bot serão discutidos em outro post.

Agora, abra o arquivo `.Renviron` e insira a seguinte linha de código:

```
R_TELEGRAM_BOT_botname = <TOKEN>
```

Observe que o final da chave `R_TELEGRAM_BOT_` tem o mesmo nome que colocamos como argumento na função `Updater` no código `bot.R` - Portanto, editável.

### Criando uma imagem Docker

Veja, que até o momento, não falamos sobre instalar o R na máquina.

Como o que nos interessa, é que o container gerado pela imagem Docker tenha o R, não precisamos instalar o software na máquina em si.

Uma imagem docker é o produto da compilação do arquivo chamado `dockerfile`.

O `dockerfile` possui o conjunto de regras que deverão ser realizadas para criar um ambiente adequado à nossa aplicação.

Felizmente, não precisaremos tirar da cartola tudo que precisamos instalar para ter o R operacional dentro de um container Docker.

A comunidade [`rocker`](https://github.com/rocker-org/rocker) escreve e homologa imagens Docker para diversas aplicações do R.

Usaremos como template o `dockerfile` da imagem [`r-ver`](https://hub.docker.com/r/rocker/r-ver/dockerfile).

Para isso, crie o arquivo `dockerfile`:

```
touch dockerfile
``` 

E o edite adicionando as seguintes linhas de código Docker:

```
FROM debian:stretch

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/rocker-org/rocker-versioned" \
      org.label-schema.vendor="Rocker Project" \
      maintainer="Carl Boettiger <cboettig@ropensci.org>"

ARG R_VERSION
ARG BUILD_DATE
ENV R_VERSION=${R_VERSION:-3.6.0} \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    TERM=xterm

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    bash-completion \
    ca-certificates \
    file \
    fonts-texgyre \
    g++ \
    gfortran \
    gsfonts \
    libblas-dev \
    libbz2-1.0 \
    libcurl3 \
    libicu57 \
    libjpeg62-turbo \
    libopenblas-dev \
    libpangocairo-1.0-0 \
    libpcre3 \
    libpng16-16 \
    libreadline7 \
    libtiff5 \
    liblzma5 \
    locales \
    make \
    unzip \
    zip \
    zlib1g \
  && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen en_US.utf8 \
  && /usr/sbin/update-locale LANG=en_US.UTF-8 \
  && BUILDDEPS="curl \
    default-jdk \
    libbz2-dev \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libicu-dev \
    libpcre3-dev \
    libpng-dev \
    libreadline-dev \
    libtiff5-dev \
    liblzma-dev \
    libx11-dev \
    libxt-dev \
    perl \
    tcl8.6-dev \
    tk8.6-dev \
    texinfo \
    texlive-extra-utils \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-latex-recommended \
    x11proto-core-dev \
    xauth \
    xfonts-base \
    xvfb \
    zlib1g-dev" \
  && apt-get install -y --no-install-recommends $BUILDDEPS \
  && cd tmp/ \
  ## Download source code
  && curl -O https://cran.r-project.org/src/base/R-3/R-${R_VERSION}.tar.gz \
  ## Extract source code
  && tar -xf R-${R_VERSION}.tar.gz \
  && cd R-${R_VERSION} \
  ## Set compiler flags
  && R_PAPERSIZE=letter \
    R_BATCHSAVE="--no-save --no-restore" \
    R_BROWSER=xdg-open \
    PAGER=/usr/bin/pager \
    PERL=/usr/bin/perl \
    R_UNZIPCMD=/usr/bin/unzip \
    R_ZIPCMD=/usr/bin/zip \
    R_PRINTCMD=/usr/bin/lpr \
    LIBnn=lib \
    AWK=/usr/bin/awk \
    CFLAGS="-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g" \
    CXXFLAGS="-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g" \
  ## Configure options
  ./configure --enable-R-shlib \
               --enable-memory-profiling \
               --with-readline \
               --with-blas \
               --with-tcltk \
               --disable-nls \
               --with-recommended-packages \
  ## Build and install
  && make \
  && make install \
  ## Add a default CRAN mirror
  && echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site \
  ## Add a library directory (for user-installed packages)
  && mkdir -p /usr/local/lib/R/site-library \
  && chown root:staff /usr/local/lib/R/site-library \
  && chmod g+wx /usr/local/lib/R/site-library \
  ## Fix library path
  && echo "R_LIBS_USER='/usr/local/lib/R/site-library'" >> /usr/local/lib/R/etc/Renviron \
  && echo "R_LIBS=\${R_LIBS-'/usr/local/lib/R/site-library:/usr/local/lib/R/library:/usr/lib/R/library'}" >> /usr/local/lib/R/etc/Renviron \
  ## install packages from date-locked MRAN snapshot of CRAN
  && [ -z "$BUILD_DATE" ] && BUILD_DATE=$(TZ="America/Los_Angeles" date -I) || true \
  && MRAN=https://mran.microsoft.com/snapshot/${BUILD_DATE} \
  && echo MRAN=$MRAN >> /etc/environment \
  && export MRAN=$MRAN \
  && echo "options(repos = c(CRAN='$MRAN'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site \
  ## Use littler installation scripts
  && Rscript -e "install.packages(c('littler', 'docopt'), repo = '$MRAN')" \
  && ln -s /usr/local/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
  && ln -s /usr/local/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
  && ln -s /usr/local/lib/R/site-library/littler/bin/r /usr/local/bin/r \
  ## Clean up from R source install
  && cd / \
  && rm -rf /tmp/* \
  && apt-get remove --purge -y $BUILDDEPS \
  && apt-get autoremove -y \
  && apt-get autoclean -y \
  && rm -rf /var/lib/apt/lists/*

CMD ["R"]
```

Este é exatamente o mesmo `dockerfile` do [`rocker:r-ver`](https://hub.docker.com/r/rocker/r-ver/dockerfile).

Com ele, o R na versão 3.6.0 seria instalado juntamente com diversos pacotes linux necessários para seu funcionamento.

Vamos adaptá-lo para nosso contexto!

### Criando a imagem docker de nosso bot

Vamos editar nosso `dockerfile`.

Primeiro, removendo a seguinte linha:

```
CMD ["R"]
```

Essa linha existia para que, quando o container fosse iniciado, uma sessão do R fosse aberta para trabalho.

No nosso caso, o que desejamos é que nosso `bot.R` seja executado.

Adicionamos nas últimas linhas o seguinte código:

```
RUN apt-get update \
    && apt-get install -y libcurl4-openssl-dev \
      libssl-dev
```

Com isso adicionamos duas bibliotecas importantes para o pacote `telegram.bot` funcionar.

Em seguida, adicionamos:

```
COPY / /
```

Com este comando, a imagem gerada copiará os arquivos que estão na pasta do dockerfile para dentro do container - nesse caso, o `bot.R` e o `.Renviron`.

Pulamos mais algumas linhas para adicionar o comando de instalação do pacote `telegram.bot`dentro do container:

```
RUN R -e "install.packages('telegram.bot', dependencies = TRUE)"
```

Finalmente, informamos que o container, quando iniciado, deve executar o código `bot.R` através do RScript.

```
ENTRYPOINT ["Rscript", "bot.R"]
```

Salve as edições e saia do arquivo.

O arquivo finalizado pode ser encontrad

<script src="https://gist.github.com/adelmofilho/2451563b93e2fcde8c76d2ba91291f5e.js"></script>