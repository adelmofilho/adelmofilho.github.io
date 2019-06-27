---
layout: post
title: Instalando um servidor Shiny-R em seu Raspberry Pi 3
subtitle: Ai ele falou "Então é possível?"
bigimg: /img/rasp_header.jpg
tags: [r, rstudio, packages, devtools, usethis]
comments: true
draft: true
output:
  html_document:
    keep_md: true
---

Instalar R, Shiny/RStudio Server em meu [Raspberry Pi 3](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/) (a.k.a Verônica) tem sido aquele tipo de experiência ....

![](./img/rasp1.jpg)

Em 2018, foi a primeira fez que fiz todo o ecossistema funcionar, e, realmente, (pra mim) foi bem complicado pelo fato de:

1. O Shiny Server [não possui pré-compilados](https://www.rstudio.com/products/shiny/download-server/) para distribuições linux da arquitetura ARM (processor do Raspberry);

2. Haviam pouquissimos tutoriais na internet (isso não mudou muito) e todos com suas particularidades;

3. Eu era um completo NOOB em linux (isso não mudou muito);

4. O código-fonte do Shiny Server possuia "incompatibilidades" com o Raspberry Pi 3 - Isso tornava a instalação do servidor um trabalho de formiguinha, já que era necessário entender o que deveria ser alterado em cada script.

Esse último ponto, inclusive,  me rendeu um [pull request](https://github.com/rstudio/shiny-server/pull/352) no github do [Shiny Server](https://github.com/rstudio/shiny-server) que me orgulho muito 😊  



## Chamado para Aventura

Certo dia [@pyspark2](https://twitter.com/pyspark2) aparece no zap com uma missão: Instalar o R 3.5 no Raspberry dele.  

<div style="width:100%;height:0;padding-bottom:58%;position:relative;"><iframe src="https://giphy.com/embed/ly8G39g1ujpNm" width="100%" height="100%" style="position:absolute" frameBorder="0" class="giphy-embed" allowFullScreen></iframe></div><div align="center"><p align="center">Fiquei, no mínimo, nervoso</p></div>


Prontamente, tirei Verônica da gaveta, conectei todos os cabos e... FORMATEI O CARTÃO DE MEMÓRIA.

<div style="width:100%;height:0;padding-bottom:56%;position:relative;"><iframe src="https://giphy.com/embed/d10dMmzqCYqQ0" width="100%" height="100%" style="position:absolute" frameBorder="0" class="giphy-embed" allowFullScreen></iframe></div><div align="center"><p align="center">Lembrar que eu formatei aquele microSD ainda machuca</p></div>

Bem... esse foi o inicio de um mês, reaprendendo tudo que fiz no ano passado, descobrindo aspectos que deixei passar na primeira vez, e, finalmente, registrando tudo.

<div style="width:100%;height:0;padding-bottom:56%;position:relative;"><iframe src="https://giphy.com/embed/t3Mzdx0SA3Eis" width="100%" height="100%" style="position:absolute" frameBorder="0" class="giphy-embed" allowFullScreen></iframe></div>


## Do começo

Eu não espero que você tenha instalado nada em seu Rpi.

Por isso, o primeiro passo é baixar a imagem do sistema operacional bootavel.

Minha recomendação e sistema operacional utilizado nesse post tutorial é o Raspbian Stretch que pode ser baixado [AQUI](https://www.raspberrypi.org/downloads/raspbian/)

Seja o dowload direto ZIP ou por torrent, eu recomendo a imagem 
*Raspbian Stretch with desktop and recommended software* por ter uma interface mínima e já ter alguns softwares inclusos.

Após o download da imagem, se você estiver em um Windows utilize o programa [RUFUS](https://rufus.ie/) para criar um bootavel com o cartão microSD do seu Raspberry Pi. Se você estiver em um Linux você sabe o que fazer (eu confio!).

![](./img/rufus.PNG "Tela do RUFUS")


## Primeiros Passos no Pi

Conecte o cartão microSD com a imagem bootavel em seu Raspberry Pi.

## Uma configuração inicial

A instalação  e compilação de alguns pacotes (DPLYR!!!) do R exige mais memória do que a disponível por padrão em seu Raspberry Pi.

Vamos adicionar 4GB de memória swap para evitar qualquer problemas.  

```
sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=4096
sudo /sbin/mkswap /var/swap.1
sudo /sbin/swapon /var/swap.1
sudo sh -c 'echo "/var/swap.1 swap swap defaults 0 0 " >> /etc/fstab'
```

Conforme dica de [@andresrcs](https://twitter.com/andresrcs), adicionemos uma configuração para evitar o uso desnecessário de memoria SWAP. Abrindo o arquivo `sysctl.conf`:

```
sudo nano /etc/sysctl.conf
```

E adicionando o seguinte parâmetro na última linha do arquivo:

```
vm.swappiness=10
```

## Instalando R

Como a instalação do R será feita pela compilação do código fonte (a versão do R disponível nos repositórios deb ainda é a 3.4.3), instalaremos algumas bibliotecas linux para o sucesso do processo.

Muitos destas bibliotecas não são mandatórias, mas permitirão a correta configuração de diversos pacotes R.

```
sudo apt-get install -y gfortran libreadline6-dev libx11-dev libxt-dev \
       libpng-dev libjpeg-dev libcairo2-dev xvfb \
       gdebi-core  libcurl4-openssl-dev  libssl-dev  \ 
       libxml2-dev libudunits2-dev libgdal-dev \
       libbz2-dev libzstd-dev liblzma-dev \
       libcurl4-openssl-dev \
       texinfo texlive texlive-fonts-extra \
       screen wget openjdk-8-jdk
```

A instalação via código fonte tem sua documentação detalhada no no [manual de instalação e administração do R] (https://cran.r-project.org/doc/manuals/r-release/R-admin.html).

No código abaixo (que leva o tempo de preparar um omelete para finalizar), o que há de diferencial são as [capabilidades](https://www.rdocumentation.org/packages/base/versions/3.6.0/topics/capabilities) que adicionamos (cairo, jpeg, shlib etc.) à instalação do R.

```
cd /usr/src
sudo wget https://cran.rstudio.com/src/base/R-3/R-3.6.0.tar.gz
sudo su
tar zxvf R-3.6.0.tar.gz
cd R-3.6.0
./configure --with-cairo --with-jpeglib --enable-R-shlib --with-blas --with-lapack
make
make install
cd ..
rm -rf R-3.6.0*
exit
cd
```

Em seguida, fazemos a instalação de diferentes pacotes R. 

Muitos deles estão listados para o correto funcionamento do shiny-server.

A instalação via terminal, na síntaxe apresentada, não é a toa.

Desta forma, garantimos que todos os usuários do servidor tenham acesso aos mesmos pacotes. Dica vindo do [@daattali](https://deanattali.com/2015/05/09/setup-rstudio-shiny-server-digital-ocean/).

```
sudo su - -c "R -e \"install.packages('Rcpp', repos='http://cran.rstudio.com/', dependencies = TRUE)\""
sudo su - -c "R -e \"install.packages('shiny', repos='http://cran.rstudio.com/', dependencies = TRUE)\""
sudo su - -c "R -e \"install.packages('rmarkdown', repos='http://cran.rstudio.com/', dependencies = TRUE)\""
sudo su - -c "R -e \"install.packages('tidyverse', repos='http://cran.rstudio.com/', dependencies = TRUE)\""
sudo su - -c "R -e \"install.packages('Cairo', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('httpuv', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('mime', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('jsonlite', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('digest', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('htmltools', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('xtable', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('R6', repos='http://cran.rstudio.com/')\""
```

Uma vez que o R está instalado (teste!), vamos passar a preparar o servidor shiny.

Instalamos o [nginx](https://www.nginx.com/) para administrar nosso servidor.

```
sudo apt install nginx
```

O Shiny Server não possui suporte para a arquitetura do raspberry, o que nos obriga a compilar o código fonte disponivel no [github](https://github.com/rstudio/shiny-server/).

Para a compilação, usaremos o [CMake](https://cmake.org/)!

No código abaixo estamos utilizando a versão mais recente do CMake. Verifique, antes de rodar, se está continua sendo a mais recente pelo site https://cmake.org/files/ e faça as alterações diretamente no código.

```
wget https://cmake.org/files/v3.14/cmake-3.14.3.tar.gz
sudo tar xzf cmake-3.14.3.tar.gz
cd cmake-3.14.3
sudo ./configure
sudo make
sudo make install
cd
```

No próximo chuck de código tratamos de fazer o download do código fonte e configurar argumentos da instalação (diretórios e hash).

Observe que podemos realizar a instalação em qualquer diretório de interesse pelo argumento `DCMAKE_INSTALL_PREFIX`. Optamos por selecionar o `/opt` por ser o diretório padrão das instalações pré-compiladas do shiny-server em outras distribuições deb.

Esse é o momento ideal para lavar o banheiro, dormir ou encontrar um rôle pra passar o tempo. Realmente, demora!

```
git clone https://github.com/rstudio/shiny-server.git
cd shiny-server
DIR=`pwd`
PATH=$DIR/bin:$PATH
mkdir tmp
cd tmp
PYTHON=`which python`
sudo cmake -DCMAKE_INSTALL_PREFIX=/opt -DPYTHON="$PYTHON" ../
sudo make
sudo mkdir ../build
sed -i '8s/.*/NODE_SHA256=7a2bb6e37615fa45926ac0ad4e5ecda4a98e2956e468dedc337117bfbae0ac68/' ../external/node/install-node.sh
sed -i 's/linux-x64.tar.xz/linux-armv7l.tar.xz/' ../external/node/install-node.sh
(cd .. && sudo ./external/node/install-node.sh)
(cd .. && ./bin/npm --python="${PYTHON}" install --no-optional)
(cd .. && ./bin/npm --python="${PYTHON}" rebuild)
sudo make install
```

Nosso próximo passo é configurar o shiny server instalado, criando e dando permissões.

Observe que estamos criando e dando permissões ao usuário `shiny` - usuário padrão do shiny.

Finalmente, fazemos o download do arquivo padrão de configuração do shiny-server diretamente no diretório do servidor.

```
cd
sudo ln -s /opt/shiny-server/bin/shiny-server /usr/bin/shiny-server
sudo useradd -r -m shiny
sudo mkdir -p /var/log/shiny-server
sudo mkdir -p /srv/shiny-server
sudo mkdir -p /var/lib/shiny-server
sudo chown shiny /var/log/shiny-server
sudo mkdir -p /etc/shiny-server
cd
sudo wget \
https://raw.githubusercontent.com/rstudio/shiny-server/master/config/default.config \
-O /etc/shiny-server/shiny-server.conf
sudo chmod 777 -R /srv
```

Finalizamos a configuração populando o arquivo `shiny-server.service`.

```
sudo nano /lib/systemd/system/shiny-server.service # Paste the following
```

Adicione as seguintes linhas de código no arquivo aberto e salve-o em seguida.

```
#!/usr/bin/env bash
[Unit]
Description=ShinyServer
[Service]
Type=simple
ExecStart=/usr/bin/shiny-server
Restart=always
# Environment="LANG=en_US.UTF-8"
ExecReload=/bin/kill -HUP $MAINPID
ExecStopPost=/bin/sleep 5
RestartSec=1
[Install]
WantedBy=multi-user.target
````

Finalmente, podemos colocar nosso shiny-server para funcionar com os seguintes comandos:

```
sudo chown shiny /lib/systemd/system/shiny-server.service
sudo systemctl daemon-reload
sudo systemctl enable shiny-server
sudo systemctl start shiny-server
```

Neste momento, você já poderá acessar seu servidor via `localhost:8787`.

# ADICIONAR A IMAGEM ESQUECE NÃO AMIGO

Adicionamos o usuário `pi` (padrão do raspberry) e `shiny` (padrão do shiny-server) ao grupo `shiny-apps` e adicionamos demais permissões.

```
sudo groupadd shiny-apps
sudo usermod -aG shiny-apps pi
sudo usermod -aG shiny-apps shiny
cd /srv/shiny-server
sudo chown -R pi:shiny-apps .
sudo chmod g+w .
sudo chmod g+s .
```

Na imagem acima, com certeza você observou alguns erros nos plots (que deveriam estar ok).

Os exemplos (sample-apps) que viriam por padrão na instalação pré-compilada do shiny-server não são incorporados na pasta do servidor. Sanamos esta situação copiando eles diretamente do código fonte.

```
mkdir /srv/shiny-server/sample-apps
sudo cp -r shiny-server/samples/sample-apps/* /srv/shiny-server/sample-apps
sudo cp shiny-server/samples/welcome.html /srv/shiny-server/index.html
```

Além disso as bibliotecas `pandoc` e `pandoc-citeproc`, que vem instalados por padrão pelo código-fonte do shiny, não são compativeis com a arquitetura do raspberry pi.

Para contornar essa situação realizamos a instalação das bilbiotecas pelo apt-get e copiamos os arquivos diretamente da instalação nativa.

```
sudo apt-get install pandoc
sudo apt-get install pandoc-citeproc

sudo cp /usr/bin/pandoc /opt/shiny-server/ext/pandoc/pandoc
sudo cp /usr/bin/pandoc-citeproc /opt/shiny-server/ext/pandoc/pandoc-citeproc

sudo systemctl restart shiny-server
```

Com estas 


## Referências 

https://github.com/rstudio/shiny-server/wiki/Building-Shiny-Server-from-Source

https://community.rstudio.com/t/setting-up-your-own-shiny-server-rstudio-server-on-a-raspberry-pi-3b/18982

https://steemit.com/tutorial/@m4rk.h4nn4/how-to-install-and-run-shiny-server-on-the-raspberry-pi-3-and-raspian-jassie-lite

https://deanattali.com/2015/05/09/setup-rstudio-shiny-server-digital-ocean/

http://herb.h.kobe-u.ac.jp/raspiinfo/rstudio_en.html

https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Installing-R-under-Unix_002dalikes

## E se você chegou até aqui, meu muito obrigado!

<div style="width:100%;height:0;padding-bottom:58%;position:relative;"><iframe src="https://giphy.com/embed/5wWf7GW1AzV6pF3MaVW" width="100%" height="100%" style="position:absolute" frameBorder="0" class="giphy-embed" allowFullScreen></iframe></div>



<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
});
</script>

<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
