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



````
# Criar pacote de funções em R

## Pacotes necessários
library(devtools)
library(roxygen2)
library(testthat)
library(knitr)
library(usethis)
library(covr)
library(testthat)

# Configurações startup ------------------------------------------------------------------

## Criar pacote:
usethis::create_package("C:/Users/Adelmo Filho/Dropbox/HopeCO/kRypto")

## Use GITHUB
usethis::use_git(message = "Initial commit")

usethis::browse_github_pat()

usethis::edit_r_environ()



  # Deixar o Renviron com uma linha em branca no fim

usethis::use_github(protocol = "https")

usethis::use_github_links()

usethis::use_data(cryptocurrency_list)

## Definir Licença do pacote
usethis::use_gpl3_license("tenispolaR")

## Criar readme.md
usethis::use_readme_md()

## Definir as badges do pacote
usethis::use_cran_badge()
usethis::use_lifecycle_badge("stable")

## Usar travis no pacote (logar no travis antes)  += Continuous integration
usethis::use_travis(browse = interactive())
usethis::use_coverage(type = c("codecov"))
usethis::use_appveyor()

## Criar o testthat para o pacote
usethis::use_testthat()

## Adicionar logo
usethis::use_logo("C:/Users/Adelmo Filho/Documents/logo.png")


# Configurações contínuas ----------------------------------------------------------------

## Criar funções em scripts .R na pasta R
usethis::use_r("encryption")

## Selecionar os pacotes que serão instalados em paralelo
usethis::use_package("testthat", type = "Suggests")
usethis::use_package("stringi", type = "Imports")
usethis::use_package("xml2", type = "Imports")
usethis::use_package("rvest", type = "Imports")
usethis::use_package("dplyr", type = "Imports")
usethis::use_package("purrr", type = "Imports")
usethis::use_package("stringr", type = "Imports")
usethis::use_package("httr", type = "Imports")
usethis::use_package("lubridate", type = "Imports")


## Criar os arquivos para testthat
usethis::use_test("listing")

## Rodar a cada release

# Restart R Session (Ctrl+Shift+F10)
# Document Package (Ctrl+Shift+D)
# Check Package (Ctrl+Shift+E)

usethis::use_version()

## Construir pacote
devtools::build()

## Criar site
pkgdown::build_site()

```


<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
});
</script>

<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>