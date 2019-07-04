---
layout: post
title: Criando seu pacote em R
bigimg: /img/mickey.gif
tags: [r, rstudio, packages, devtools, usethis]
comments: true
draft: true
output:
  html_document:
    keep_md: true
---

Na minha última contagem, o [CRAN](https://cran.r-project.org/) já era povoado com 13.782 pacotes. É muita documentação pra ler!!! 😨

Experimente ver quantos pacotes temos disponíveis agora com o chunk de código abaixo.

```r
nrow(available.packages())
```

Hadley escreve em seu [livro](http://r-pkgs.had.co.nz/): 

> **pacotes são unidades fundamentais de códigos R reproduzíveis**

E, digo, esta frase é mais problemática que indireta em whatsapp - tem que ler umas trocentas vezes pra pegar o sentido.

,,,,,,,,,,,,,



<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
});
</script>

<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
