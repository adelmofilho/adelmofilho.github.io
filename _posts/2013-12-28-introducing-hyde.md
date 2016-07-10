# Planejamento de experimentos em R
Adelmo Filho ( <aguiar.soul@gmail.com> )  
`r format(Sys.time(), '%d %B, %Y')`  



<br>

# Pacote de funções [FrF2](https://cran.r-project.org/web/packages/FrF2/FrF2.pdf)

<p style="text-align: justify;">Existe, para a linguagem R, uma grande quantidade de pacotes de funções para planejamento de experimentos (DoE) em razão da diversidade de designs existentes para além dos clássicos $2^k$ completo e fracionado, e.g. spit-plot, blocos incompletos, quadrado latino etc. Como para nossas aplicações, os designs clássicos serão suficientes, trabalharemos com o pacote de funções [FrF2](https://cran.r-project.org/web/packages/FrF2/FrF2.pdf).</p>


```r
install.packages("FrF2", repos = "http://cran.rstudio.com/") # Instala o pacote
library(FrF2) # Carrega o pacote para uso
```
<br>

# Geração do design

<p style="text-align: justify;">Selecionar o melhor design para seu experimento nem sempre é uma tarefa usual. Ela depende de fatores como:</p>

- Tempo disponível para os experimentos;
- Recurso financeiro / material para os experimentos;
- Objetivo desejado (avaliar a significância dos fatores ou construir um modelo?);
- Grau permitido confundimento dos fatores;
- Número de fatores do seu experimento.

<p style="text-align: justify;">A tabela abaixo é uma representação dos diferentes designs permitidos para um planejamento $2^k$.</p>

![](./Pictures/doe_resolution.JPG)

<br>

<p style="text-align: justify;">Três informações necessárias para descrever seu design são obtidas por meio desta tabela: número de experimentos (runs), número de fatores (factors) e a resolução do experimento (em algarismos romanos em cada célula da tabela). Informando, ao menos duas destas informações, a terceira é definida automaticamente, e é desta forma que as funções pra design de experimentos do pacote [FrF2](https://cran.r-project.org/web/packages/FrF2/FrF2.pdf) operam.</p>
<br>

## Planejamento $2^k$ completo

<p style="text-align: justify;"> Para construir um design de experimento $2^k$ completo, basta entrar com a função **FrF2** e informar o número $k$ de fatores (nfactors) desejados e, em seguida, definir o número de experimentos (nruns) como $2^k$.</p>

<p style="text-align: justify;"> No exemplo abaixo, um design $2^4$ completo foi criado, neste apenas uma replicação foi realizada (replications) e a ordem dos experimentos foi randomizada (randomize = TRUE).</p>


```r
plan.completo = FrF2(nfactors = 4,
                     nruns = 2^4,
                     replications = 1,
                     randomize = TRUE)

summary(plan.completo)
```

```
## Call:
## FrF2(nfactors = 4, nruns = 2^4, replications = 1, randomize = TRUE)
## 
## Experimental design of type  full factorial 
## 16  runs
## 
## Factor settings:
##    A  B  C  D
## 1 -1 -1 -1 -1
## 2  1  1  1  1
## 
## The design itself:
##     A  B  C  D
## 1   1 -1 -1 -1
## 2  -1 -1  1  1
## 3  -1 -1  1 -1
## 4   1  1  1  1
## 5   1 -1  1 -1
## 6  -1 -1 -1 -1
## 7   1  1  1 -1
## 8   1  1 -1 -1
## 9  -1  1 -1 -1
## 10 -1  1 -1  1
## 11  1 -1 -1  1
## 12  1  1 -1  1
## 13 -1  1  1  1
## 14 -1  1  1 -1
## 15 -1 -1 -1  1
## 16  1 -1  1  1
## class=design, type= full factorial
```

<p style="text-align: justify;">Ao solicitar o **summary** do design criado, são informados detalhes como o número total de experimentos (16), os níveis dos fatores (por definição iguais a "-1" e "1") e o próprio design randomizado. Os fatores são, por padrão, representados por letras maiúsculas.</p>
<br>

## Planejamento $2^k$ fracionado

<p style="text-align: justify;">A forma mais simples de criar um design fracionado é selecionar o número de fatores do experimento e a resolução desejada. No exemplo abaixo, um experimento com oito fatores e resolução IV é criado, o número de experimentos é calculado pela função.</p>


```r
plan.frac.1 = FrF2(nfactors = 8,
                   resolution = 4, 
                   replications = 1,
                   randomize = TRUE)

summary(plan.frac.1)
```

```
## Call:
## FrF2(nfactors = 8, resolution = 4, replications = 1, randomize = TRUE)
## 
## Experimental design of type  FrF2 
## 16  runs
## 
## Factor settings (scale ends):
##    A  B  C  D  E  F  G  H
## 1 -1 -1 -1 -1 -1 -1 -1 -1
## 2  1  1  1  1  1  1  1  1
## 
## Design generating information:
## $legend
## [1] A=A B=B C=C D=D E=E F=F G=G H=H
## 
## $generators
## [1] E=ABC F=ABD G=ACD H=BCD
## 
## 
## Alias structure:
## $fi2
## [1] AB=CE=DF=GH AC=BE=DG=FH AD=BF=CG=EH AE=BC=DH=FG AF=BD=CH=EG AG=BH=CD=EF
## [7] AH=BG=CF=DE
## 
## 
## The design itself:
##     A  B  C  D  E  F  G  H
## 1   1  1  1  1  1  1  1  1
## 2  -1  1 -1  1  1 -1  1 -1
## 3   1  1  1 -1  1 -1 -1 -1
## 4   1 -1  1 -1 -1  1 -1  1
## 5   1 -1 -1 -1  1  1  1 -1
## 6  -1  1 -1 -1  1  1 -1  1
## 7   1 -1 -1  1  1 -1 -1  1
## 8  -1  1  1  1 -1 -1 -1  1
## 9  -1 -1 -1  1 -1  1  1  1
## 10  1  1 -1  1 -1  1 -1 -1
## 11 -1 -1  1  1  1  1 -1 -1
## 12 -1  1  1 -1 -1  1  1 -1
## 13 -1 -1  1 -1  1 -1  1  1
## 14  1  1 -1 -1 -1 -1  1  1
## 15 -1 -1 -1 -1 -1 -1 -1 -1
## 16  1 -1  1  1 -1 -1  1 -1
## class=design, type= FrF2
```

<p style="text-align: justify;">O **summary** de um design fracionado retorna, além das informações contidas no summary de um design completo, os geradores do design (generators) e os confundimentos entre fatores (Alias structure).</p>

<p style="text-align: justify;">É possível ainda, criar um design fracionado informando o número de fatores (nfactors) e o número de experimentos (nruns). Mas, neste caso é necessário informar valores coerentes e que resultem em uma resolução igual ou maior que III. Infelizmente, não é possível entrar com um número de experimentos que não seja proporcional a $2^k$, para assim o programa selecionar o design com a maior resolução, ou seja, use a tabela ao seu favor.</p>

<p style="text-align: justify;">No exemplo abaixo, temos um experimento $2^{8-4}$ fatorial, que possui uma resolução IV.</p>


```r
plan.frac.2 = FrF2(nfactors = 8,
                   nruns = 32, 
                   replications = 1,
                   randomize = TRUE)

summary(plan.frac.2)
```

```
## Call:
## FrF2(nfactors = 8, nruns = 32, replications = 1, randomize = TRUE)
## 
## Experimental design of type  FrF2 
## 32  runs
## 
## Factor settings (scale ends):
##    A  B  C  D  E  F  G  H
## 1 -1 -1 -1 -1 -1 -1 -1 -1
## 2  1  1  1  1  1  1  1  1
## 
## Design generating information:
## $legend
## [1] A=A B=B C=C D=D E=E F=F G=G H=H
## 
## $generators
## [1] F=ABC  G=ABD  H=ACDE
## 
## 
## Alias structure:
## $fi2
## [1] AB=CF=DG AC=BF    AD=BG    AF=BC    AG=BD    CD=FG    CG=DF   
## 
## 
## The design itself:
##     A  B  C  D  E  F  G  H
## 1  -1 -1  1  1 -1  1  1  1
## 2   1  1  1  1 -1  1  1 -1
## 3   1 -1 -1 -1  1  1  1  1
## 4   1  1 -1 -1  1 -1 -1  1
## 5   1  1 -1  1  1 -1  1 -1
## 6   1 -1 -1  1  1  1 -1 -1
## 7  -1 -1  1 -1  1  1 -1  1
## 8   1 -1  1 -1 -1 -1  1  1
## 9  -1 -1 -1 -1  1 -1 -1 -1
## 10 -1 -1  1 -1 -1  1 -1 -1
## 11 -1 -1 -1  1 -1 -1  1 -1
## 12 -1 -1 -1  1  1 -1  1  1
## 13 -1 -1 -1 -1 -1 -1 -1  1
## 14 -1  1 -1 -1  1  1  1 -1
## 15  1  1  1  1  1  1  1  1
## 16 -1  1 -1  1 -1  1 -1 -1
## 17 -1  1  1  1 -1 -1 -1  1
## 18  1 -1  1  1  1 -1 -1  1
## 19 -1  1 -1  1  1  1 -1  1
## 20  1 -1  1  1 -1 -1 -1 -1
## 21  1  1 -1  1 -1 -1  1  1
## 22  1  1 -1 -1 -1 -1 -1 -1
## 23 -1  1 -1 -1 -1  1  1  1
## 24 -1  1  1  1  1 -1 -1 -1
## 25 -1  1  1 -1  1 -1  1  1
## 26  1 -1 -1  1 -1  1 -1  1
## 27 -1 -1  1  1  1  1  1 -1
## 28  1 -1  1 -1  1 -1  1 -1
## 29  1  1  1 -1 -1  1 -1  1
## 30  1  1  1 -1  1  1 -1 -1
## 31  1 -1 -1 -1 -1  1  1 -1
## 32 -1  1  1 -1 -1 -1  1 -1
## class=design, type= FrF2
```

<p style="text-align: justify;">Uma forma menos usual de criar um design fracionado é utilizando um gerador. No exemplo abaixo, o gerador do design foi o $D = -AB$. Isto permite a seleção da meia-fração de experimentos a ser realizada, apenas com mudança de sinal da função geradora.</p>


```r
plan.frac.3 = FrF2(generators = -c(3),
                   nruns = 2^3, 
                   replications = 1,
                   randomize = TRUE)

summary(plan.frac.3)
```

```
## Call:
## FrF2(generators = -c(3), nruns = 2^3, replications = 1, randomize = TRUE)
## 
## Experimental design of type  FrF2.generators 
## 8  runs
## 
## Factor settings (scale ends):
##    A  B  C  D
## 1 -1 -1 -1 -1
## 2  1  1  1  1
## 
## Design generating information:
## $legend
## [1] A=A B=B C=C D=D
## 
## $generators
## [1] D=-AB
## 
## 
## Alias structure:
## $main
## [1] A=-BD B=-AD D=-AB
## 
## 
## The design itself:
##    A  B  C  D
## 1 -1 -1 -1 -1
## 2  1 -1 -1  1
## 3 -1 -1  1 -1
## 4 -1  1 -1  1
## 5  1  1  1 -1
## 6 -1  1  1  1
## 7  1  1 -1 -1
## 8  1 -1  1  1
## class=design, type= FrF2.generators
```

## Planejamento $2^k$ com ponto central

<p style="text-align: justify;">Quando deseja-se estudar não linearidades no comportamento dos fatores, a adição de um ponto central é essencial ao design. Para fazer isso, entra-se com o argumento **ncenter** e o número de pontos centrais. No exemplo abaixo, observe que foi selecionado duas replicações.</p>


```r
plan.central = FrF2(nfactors = 4,
                   nruns = 2^3,
                   ncenter = 1,
                   replications = 2,
                   randomize = TRUE)

summary(plan.central)
```

```
## Call:
## FrF2(nfactors = 4, nruns = 2^3, ncenter = 1, replications = 2, 
##     randomize = TRUE)
## 
## Experimental design of type  FrF2.center 
## 9  runs
## each run independently conducted  2  times
## 
## Factor settings (scale ends):
##    A  B  C  D
## 1 -1 -1 -1 -1
## 2  1  1  1  1
## 
## Design generating information:
## $legend
## [1] A=A B=B C=C D=D
## 
## $generators
## [1] D=ABC
## 
## 
## Alias structure:
## $fi2
## [1] AB=CD AC=BD AD=BC
## 
## 
## The design itself:
##    run.no run.no.std.rp  A  B  C  D
## 1       1           7.1 -1  1  1 -1
## 2       2           8.1  1  1  1  1
## 3       3           1.1 -1 -1 -1 -1
## 4       4           5.1 -1 -1  1  1
## 5       5           6.1  1 -1  1 -1
## 6       6           2.1  1 -1 -1  1
## 7       7           4.1  1  1 -1 -1
## 8       8           3.1 -1  1 -1  1
## 9       9           0.1  0  0  0  0
## 91     10           4.2  1  1 -1 -1
## 10     11           3.2 -1  1 -1  1
## 11     12           1.2 -1 -1 -1 -1
## 12     13           5.2 -1 -1  1  1
## 13     14           2.2  1 -1 -1  1
## 14     15           8.2  1  1  1  1
## 15     16           7.2 -1  1  1 -1
## 16     17           6.2  1 -1  1 -1
## 17     18           0.2  0  0  0  0
## class=design, type= FrF2.center 
## NOTE: columns run.no and run.no.std.rp are annotation, not part of the data frame
```

<p style="text-align: justify;">Observe que a apresentação do design com a função **summary** toma uma nova forma. Na primeira coluna, temos a ordem padrão do  experimento. Na segunda coluna, a ordem que o pesquisador deve realizar o experimento (run.no) devido à randomização. Na terceira coluna (run.no.std.rp), a ordem padrão se repete, com o indicador da replicação como um número após o ponto.</p>

<p style="text-align: justify;">O valor 0 se reserva ao ponto central. Assim, 0.2 significa a segunda replicação do experimento cujos os fatores estão no ponto central.</p>

## Planejamento $2^k$ com blocos

<p style="text-align: justify;">A adição de blocos ao design é feita por meio do argumento **blocks**. No exemplo abaixo, um planejamento completo com 2 replicações, 2 blocos e um ponto central por bloco é realizado.</p>


```r
plan.blocos = FrF2(nfactors = 3,
                   nruns = 2^3,
                   ncenter = 1,
                   blocks = 2,
                   replications = 2,
                   randomize = TRUE)

summary(plan.blocos)
```

```
## Call:
## FrF2(nfactors = 3, nruns = 2^3, ncenter = 1, blocks = 2, replications = 2, 
##     randomize = TRUE)
## 
## Experimental design of type  FrF2.blocked.center 
## 10  runs
## blocked design with  2  blocks of size  4 
## each type of block independently conducted  2  times
## 
## Factor settings (scale ends):
##    A  B  C
## 1 -1 -1 -1
## 2  1  1  1
## 
## Design generating information:
## $legend
## [1] A=A B=B C=C
## 
## $`generators for design itself`
## [1] full factorial
## 
## $`block generators`
## [1] ABC
## 
## 
## no aliasing of main effects or 2fis among experimental factors
## 
## 
## The design itself:
##     run.no run.no.std.rp Blocks  A  B  C
## 1        1       1.1.1.1    1.1 -1 -1 -1
## 2        2       4.1.2.1    1.1 -1  1  1
## 3        3       6.1.3.1    1.1  1 -1  1
## 4        4       7.1.4.1    1.1  1  1 -1
## 5        5       0.1.0.1    1.1  0  0  0
## 51       6       3.2.2.1    2.1 -1  1 -1
## 6        7       2.2.1.1    2.1 -1 -1  1
## 7        8       8.2.4.1    2.1  1  1  1
## 8        9       5.2.3.1    2.1  1 -1 -1
## 11      10       0.2.0.1    2.1  0  0  0
## 9       11       4.1.2.2    1.2 -1  1  1
## 10      12       6.1.3.2    1.2  1 -1  1
## 111     13       1.1.1.2    1.2 -1 -1 -1
## 12      14       7.1.4.2    1.2  1  1 -1
## 13      15       0.1.0.2    1.2  0  0  0
## 131     16       8.2.4.2    2.2  1  1  1
## 14      17       3.2.2.2    2.2 -1  1 -1
## 15      18       2.2.1.2    2.2 -1 -1  1
## 16      19       5.2.3.2    2.2  1 -1 -1
## 17      20       0.2.0.2    2.2  0  0  0
## class=design, type= FrF2.blocked.center 
## NOTE: columns run.no and run.no.std.rp are annotation, not part of the data frame
```

<p style="text-align: justify;">Uma nova coluna é adicionada ao design apresentado pela função **summary** para indicar os blocos no design, juntamente com a replicação associada.</p>

## Repetições Vs. Replicações

<p style="text-align: justify;">Os exemplos até agora envolveram o uso de replicações, isto é, a repetição idêntica de determinado experimento em uma diferente unidade experimental. Caso na mesma unidade experimental sejam feitas diferentes medições da mesma variável de interesse, denominamos este processo de repetição. Para uma maior discussão sobre estes conceitos veja [Lawson (2015)](http://www.amazon.com/Analysis-Experiments-Chapman-Statistical-Science/dp/1439868131).</p>

<p style="text-align: justify;">Para criar um design com repetições, adicionamos o termo **repeat.only** igual a "TRUE", o que faz com que o número de replicações seja entendido como o número de repetições de cada experimento.</p>


```r
plan.repet = FrF2(nfactors = 3,
                  nruns = 2^3, 
                  replications = 3,
                  repeat.only = TRUE,
                  randomize = FALSE)

summary(plan.repet)
```

```
## Call:
## FrF2(nfactors = 3, nruns = 2^3, replications = 3, repeat.only = TRUE, 
##     randomize = FALSE)
## 
## Experimental design of type  full factorial 
## 8  runs
## 3  measurements per run (not proper replications)
## 
## Factor settings:
##    A  B  C
## 1 -1 -1 -1
## 2  1  1  1
## 
## The design itself:
##    run.no run.no.std.rp  A  B  C
## 1       1           1.1 -1 -1 -1
## 2       2           1.2 -1 -1 -1
## 3       3           1.3 -1 -1 -1
## 4       4           2.1  1 -1 -1
## 5       5           2.2  1 -1 -1
## 6       6           2.3  1 -1 -1
## 7       7           3.1 -1  1 -1
## 8       8           3.2 -1  1 -1
## 9       9           3.3 -1  1 -1
## 10     10           4.1  1  1 -1
## 11     11           4.2  1  1 -1
## 12     12           4.3  1  1 -1
## 13     13           5.1 -1 -1  1
## 14     14           5.2 -1 -1  1
## 15     15           5.3 -1 -1  1
## 16     16           6.1  1 -1  1
## 17     17           6.2  1 -1  1
## 18     18           6.3  1 -1  1
## 19     19           7.1 -1  1  1
## 20     20           7.2 -1  1  1
## 21     21           7.3 -1  1  1
## 22     22           8.1  1  1  1
## 23     23           8.2  1  1  1
## 24     24           8.3  1  1  1
## class=design, type= full factorial 
## NOTE: columns run.no and run.no.std.rp are annotation, not part of the data frame
```

<p style="text-align: justify;">Na tabela de design da função **summary** as repetições são indicadas da mesma forma que as replicações.</p>

## Personalização do design

<p style="text-align: justify;">Até o momento, todos os designs criados utilizaram a nomenclatura padrão para os níveis dos fatores ("-1" e "1") e o nome dos fatores (A, B, C, ...). Para personalizar esses parâmetros, usamos o argumento **factor.names** com a estrutura representada abaixo.</p>


```r
plan.person = FrF2(nruns = 16, 
                   nfactors =  4,
                   replications = 1,
                   repeat.only = FALSE,
                   factor.names = list(
                     Temperatura = c(100, 200),
                     Catalisador = c("Ausente", "Presente"),
                     Solvente = c("Água", "Etanol"),
                     Misturador = c("off", "on")),
                   randomize = FALSE)

summary(plan.person)
```

```
## Call:
## FrF2(nruns = 16, nfactors = 4, replications = 1, repeat.only = FALSE, 
##     factor.names = list(Temperatura = c(100, 200), Catalisador = c("Ausente", 
##         "Presente"), Solvente = c("Água", "Etanol"), Misturador = c("off", 
##         "on")), randomize = FALSE)
## 
## Experimental design of type  full factorial 
## 16  runs
## 
## Factor settings:
##   Temperatura Catalisador Solvente Misturador
## 1         100     Ausente     Água        off
## 2         200    Presente   Etanol         on
## 
## The design itself:
##    Temperatura Catalisador Solvente Misturador
## 1          100     Ausente     Água        off
## 2          200     Ausente     Água        off
## 3          100    Presente     Água        off
## 4          200    Presente     Água        off
## 5          100     Ausente   Etanol        off
## 6          200     Ausente   Etanol        off
## 7          100    Presente   Etanol        off
## 8          200    Presente   Etanol        off
## 9          100     Ausente     Água         on
## 10         200     Ausente     Água         on
## 11         100    Presente     Água         on
## 12         200    Presente     Água         on
## 13         100     Ausente   Etanol         on
## 14         200     Ausente   Etanol         on
## 15         100    Presente   Etanol         on
## 16         200    Presente   Etanol         on
## class=design, type= full factorial
```

<p style="text-align: justify;">Usaremos o design acima para as próximas etapas de um planejamento de experimentos em R. Esse exemplo se refere a um planejamento de experimentos para determinar os fatores mais significativos de uma reação química promovida em um reator em batelada.</p>

# Atualizando o design

<p style="text-align: justify;">Uma vez que salvamos nosso design em uma variável (plan.person), podemos atualizar o design com os resultados dos experimentos, na ordem que o design indica para realizá-los. Isso é feito com a função **add.response** que tem como argumentos, o design criado e os resultados do experimento.</p>


```r
resultados = c(760, 532, 761, 380, 708, 344, 542, 309, 
               854, 901, 642, 636, 826, 798, 511, 524)

plan.atualizado = add.response(design = plan.person, response = resultados)

summary(plan.atualizado)
```

```
## Call:
## FrF2(nruns = 16, nfactors = 4, replications = 1, repeat.only = FALSE, 
##     factor.names = list(Temperatura = c(100, 200), Catalisador = c("Ausente", 
##         "Presente"), Solvente = c("Água", "Etanol"), Misturador = c("off", 
##         "on")), randomize = FALSE)
## 
## Experimental design of type  full factorial 
## 16  runs
## 
## Factor settings:
##   Temperatura Catalisador Solvente Misturador
## 1         100     Ausente     Água        off
## 2         200    Presente   Etanol         on
## 
## Responses:
## [1] resultados
## 
## The design itself:
##    Temperatura Catalisador Solvente Misturador resultados
## 1          100     Ausente     Água        off        760
## 2          200     Ausente     Água        off        532
## 3          100    Presente     Água        off        761
## 4          200    Presente     Água        off        380
## 5          100     Ausente   Etanol        off        708
## 6          200     Ausente   Etanol        off        344
## 7          100    Presente   Etanol        off        542
## 8          200    Presente   Etanol        off        309
## 9          100     Ausente     Água         on        854
## 10         200     Ausente     Água         on        901
## 11         100    Presente     Água         on        642
## 12         200    Presente     Água         on        636
## 13         100     Ausente   Etanol         on        826
## 14         200     Ausente   Etanol         on        798
## 15         100    Presente   Etanol         on        511
## 16         200    Presente   Etanol         on        524
## class=design, type= full factorial
```

<p style="text-align: justify;">As respostas aparecem à direita da tabela contendo o design. Em nosso exemplo, não foi realizada randomização dos experimentos.</p>

# Interpretação das respostas

<p style="text-align: justify;">As principais ferramentas para interpretar os resultados de um planejamento de experimentos são discutidas a seguir.</p>

## Efeitos Principais

<p style="text-align: justify;">Os efeitos principais demonstram o impacto individual de cada fator sobre a resposta. Usamos a função **MEplot**. Os gráficos indicam um impacto negativo quando a temperatura, catalisador e solvente vão para o nível superior do fator. O inverso ocorre com o uso do misturador.</p>


```r
MEPlot(plan.atualizado)
```

<img src="Post3_files/figure-html/unnamed-chunk-11-1.png" style="display: block; margin: auto;" />

## Interações

<p style="text-align: justify;">A matriz de interações, mostrada abaixo, é gerada pela função **IAPlot**. As interações Temperatura:Misturador e Catalisador:Misturador são as que indicam uma maior interação, pelo cruzamento das curvas sob nível maior e menor dos fatores.</p>


```r
IAPlot(plan.atualizado)
```

<img src="Post3_files/figure-html/unnamed-chunk-12-1.png" style="display: block; margin: auto;" />

## Significância dos fatores

<p style="text-align: justify;">A verificação da significância dos efeitos pode ser realizada conjuntamente de forma gráfica, e por inferência através do gráfico "half normal", utilizando a função **DanielPlot** e definindo nela o nível de significância (alpha).</p>


```r
DanielPlot(plan.atualizado, 
           code = TRUE, 
           half = TRUE, 
           alpha = 0.1)
```

<img src="Post3_files/figure-html/unnamed-chunk-13-1.png" style="display: block; margin: auto;" />

**ATUALIZADO 09.06.2016**

<p style="text-align: justify;">Conforme o manual da função: "the plot at signifcance level 10% shows the same significant effects as the linear model analysis at significance level 5%".</p>

**FIM DA ATUALIZAÇÃO**

<p style="text-align: justify;">Pelo gráfico "half normal", as variáveis significativas são aquelas cuja *tag* aparece ao lado do ponto no gráfico. Em nosso caso, temos interações de até terceiro grau significativas.</p>

## Modelo de regressão

<p style="text-align: justify;">Para construir um modelo de regressão a partir dos resultados do design de experimentos, utiliza-se a função **lm**, tal como em um modelo de regressão linear, em conjunto com a função **summary** para observar diversas informações do modelo criado.</p>


```r
summary(lm(plan.atualizado))
```

```
## Number of observations used: 16 
## Formula:
## resultados ~ (Temperatura + Catalisador + Solvente + Misturador)^2
## 
## Call:
## lm.default(formula = fo, data = model.frame(fo, data = formula))
## 
## Residuals:
##      1      2      3      4      5      6      7      8      9     10 
## -28.00  35.75  36.50 -44.25  26.75 -34.50 -35.25  43.00 -19.25  11.50 
##     11     12     13     14     15     16 
##  10.75  -3.00  20.50 -12.75 -12.00   4.25 
## 
## Coefficients:
##                           Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                626.750     12.105  51.777 5.08e-08 ***
## Temperatura1               -73.750     12.105  -6.093 0.001724 ** 
## Catalisador1               -88.625     12.105  -7.322 0.000745 ***
## Solvente1                  -56.500     12.105  -4.668 0.005494 ** 
## Misturador1                 84.750     12.105   7.001 0.000916 ***
## Temperatura1:Catalisador1   -2.125     12.105  -0.176 0.867535    
## Temperatura1:Solvente1      -2.750     12.105  -0.227 0.829278    
## Temperatura1:Misturador1    77.000     12.105   6.361 0.001419 ** 
## Catalisador1:Solvente1     -10.125     12.105  -0.836 0.441033    
## Catalisador1:Misturador1   -44.625     12.105  -3.687 0.014196 *  
## Solvente1:Misturador1        9.750     12.105   0.805 0.457128    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 48.42 on 5 degrees of freedom
## Multiple R-squared:  0.9775,	Adjusted R-squared:  0.9324 
## F-statistic:  21.7 on 10 and 5 DF,  p-value: 0.001674
```

<p style="text-align: justify;">A análise do modelo e dos seus coeficientes é realizada da mesma forma que o modelo linear que desenvolvemos anteriormente. Destaca-se que o modelo default é composto por todos os termos de interação de segundo grau. Não necessariamente, aqueles que foram identificados como significativos pelo gráfico "half normal".</p>

# Referências indicadas

[GROMPING, U. R Package FrF2 for Creating and Analyzing Fractional Factorial 2-Level Designs. Journal of Statistical Software. January 2014, Volume 56, Issue 1.](https://www.dropbox.com/s/eopa1vkt0faynf6/v56i01.pdf?dl=0)


