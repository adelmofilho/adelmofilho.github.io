---
layout: post
title: "Criando um repositório git pra chamar de seu"
subtitle: "Raspberry + Gitlab"
bigimg: /img/docker.jpeg
tags: [r, rstudio, rstudio-server, data-science, docker, renv]
comments: true
draft: true
output:
  html_document:
    keep_md: true
---

Do cientista de dados até o desenvolvedor mobile, se existe uma tecnologia que conversa com todos nós, este é o `git`.

Versionar código não é somente sobre ter um backup (apesar de já ter salvo minha pele algumas vezes). 

Versionar torna mais fácil a colaboração em equipes e a resolução de bugs no código, além de tornar as mudanças no código vísiveis e documentadas (o santo commit explicativo).

Com serviços como `github` e `gitlab`, o uso do git associado a uma plataforma/interface web se popularizou até se tornar regra.

É comum empresas terem contratos com esses provedores, ou usarem infraestrutura própria para instanciar seu próprio servidor web para git.

Eu e você, mortais, consumimos essas plataformas utilizando a infraestrutura que elas nos fornecem de forma gratuita, ou paga quando necessário.

Mas...

> Apesar do tom conspiratório e alarmista das próximas palavras, elas estão aqui apenas para reflexão.

Mas, e se o serviço não for mais prestado? 

Ou, se seu código for utilizado de forma indevida ou não autorizada?

Ou ainda, a plataforma impedir seu acesso ao seu repositório git?

Parece uma teória conspiratória, mas já aconteceu recentemente, inclusive.

Foi o caso na Venezuela, quando [a Adobe removeu o acesso a usuários do photoshop aos seus projetos e ao software](https://www.fastcompany.com/90414653/adobe-shuts-down-photoshop-in-venezuela-because-of-trumps-sanctions) por conta de sanções dos EUA.

Ou com o próprio `github` em 2019, neste caso com os repositórios pagos ou privados de desenvolvedores do irã.

<center>
<blockquote class="twitter-tweet"><p lang="en" dir="ltr">To comply with US sanctions, we unfortunately had to implement new restrictions on private repos and paid accounts in Iran, Syria, and Crimea. <br><br>Public repos remain available to developers everywhere – open source repos are NOT affected.</p>&mdash; Nat Friedman (@natfriedman) <a href="https://twitter.com/natfriedman/status/1155311122137804801?ref_src=twsrc%5Etfw">July 28, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 

</center>

A discussão entre open-source e política não deve ser minimizada.

Não quero entrar no mérito da questão, até porque não li os termos de uso do software. O ponto aqui, é mesmo o que deve sempre ser lembrado ao trabalhar com serviços na cloud:

<center>
<img src="https://i.redd.it/f4f4tcoo8wu21.png"/>
</center>

Cabe a nós entendermos as limitações do uso de uma plataforma de terceiros e até onde nos sentimos confortáveis em armazenar nossa produção intelectual fora de nossas máquinas pessoais.