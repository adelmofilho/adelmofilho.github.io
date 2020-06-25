---
layout: post
title: "Estudando para a certificação AWS Cloud Practitioner"
subtitle: "Um pouco da minha experiência"
bigimg: /img/study.gif
tags: [aws, cloud, practitioner, certification]
comments: true
draft: true
output:
  html_document:
    keep_md: true
---




## TL;DR

A abordagem de montar o `docker.sock` no container, de fato, soluciona as potenciais questões de data corruption (pelo compartilhamento do `/var/lib/docker`) e de incompatibilidade entre *filesystems* relacionadas ao docker-in-docker.

Por outro lado, ao expor o `docker.sock` para o container, este se torna um ponto de vulnerabilidade, em termos de segurança, por dar acesso completo ao usuário (root) do docker da máquina host - tornando possível executar containers com código malicioso. No caso de um usuário não-root, a situação ainda piorará pela necessidade de alteração das permissões do `docker.sock`.

Finalmente, o que vai decidir a melhor abordagem são os requisitos de seu projeto e a análise dos potenciais riscos em seu ambiente produtivo.

Para facilitar o teste/implementação das abordagens citadas, disponibilizei os seguintes arquivos `docker-compose` com as instruções necessárias para executar sua aplicação Jenkins com dind ou com a montagem do socket.

#### Jenkins associado a um container docker-in-docker

<script src="https://gist.github.com/adelmofilho/5a30a87eaf1cd4a03052f37b516d6714.js"></script>

<br>

#### Container Jenkins com o docker.sock montado

<script src="https://gist.github.com/adelmofilho/5e4b2a57b402e218300332dd0a88a881.js"></script>

<br>

## Referências

[1] [Artigo original de Jérôme Petazzoni](http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)

[2] [Artigo sobre a vulnerabilidade de montar o `docker.sock`](https://dreamlab.net/en/blog/post/abusing-dockersock-exposure/)

[3] [Discussão sobre a vulnerabilidade de montar o `docker.sock`](https://forums.docker.com/t/using-docker-in-a-dockerized-jenkins-container/322)

[4] [Documentação oficial da imagem docker:dind](https://hub.docker.com/_/docker)

[5] [Instruções para execução do docker-in-docker associado ao Jenkins](https://www.jenkins.io/doc/tutorials/create-a-pipeline-in-blue-ocean/)

<br>
<center>
* * *
</center>

Agradecimentos ao [@renancmonteiro_](https://twitter.com/renancmonteiro_) pelas discussões sobre o tema!
<br>
<center>
* * *
</center>

Esta é uma modalidade de post "**rápido**", onde apresento as principais conclusões sobre algum tema e compartilho códigos que possam ajudar nos problemas envolvidos. Uma discussão detalhada será publicada e linkada posteriormente.