---
layout: post
title: "Criando um repositório git pra chamar de seu"
subtitle: "Raspberry + Gitlab"
bigimg: /img/gitmerge.gif
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

Não quero entrar no mérito da questão, até porque não li os termos de uso do software/plataforma. O ponto aqui, é o mesmo que deve sempre ser lembrado ao trabalhar com serviços na cloud:

<center>
<img src="https://i.redd.it/f4f4tcoo8wu21.png"/>
</center>

Cabe a nós entendermos as limitações do uso de uma plataforma de terceiros e até onde nos sentimos confortáveis em armazenar nossa produção intelectual fora de nossas máquinas pessoais.

Mas, e se não quisermos depender dessas empresas?

## Gitlab é open-source

A empresa `Gitlab` oferece o servidor web para repositórios git em duas modalidades: SaaS (o habitual site que acessamos) e Self-Managed (um instalável em uma máquina linux).

No caso da opção SaaS, armazenamento é de resposabilidade do `Gitlab`, enquanto segurança é gerida de forma compartilhada com o usuário. A opção Self-Managed entrega tudo na mão do usuário.

Em ambos os casos, é disponibilizado uma versão gratuita (Gitlab-CE) e uma versão paga (Gitlab-EE).

<center>
<img src="/img/gitlab.png" style="display: block; margin: auto;" />
</center>

O Gitlab-CE (Community Edition) é o projeto open-source sob licença MIT que o `Gitlab` apoia, desenvolve e suporta, o que democratiza o acesso a repositórios online de código que tanto usamos.

Resta entender, em que máquina vamos levantar o web server e armazenar nossos códigos com o Gitlab-CE.

## Raspberry Pi

Apesar de podermos instalar o Gitlab-CE em nossas máquinas (linux), isso significaria manter todo o armazenamento em um único ambiente. 

Além de que expor o serviço para outros usuários via internet poderia levar a ataques em sua máquina.

