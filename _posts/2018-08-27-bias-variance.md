---
layout: post
draft: true
output:
  html_document:
    keep_md: true
---



> Praticamente, todo livro de statistical / machine learning trata da apresentação do [dilema do bias-variância](https://en.wikipedia.org/wiki/Bias%E2%80%93variance_tradeoff) e utiliza sua inerente decomposição na discussão das técnicas de validação cruzada e sintonia de hiperparâmetros. Para além da fundamentação téorica, apresento neste post um framework básico para decomposição do bias, variância e do erro irredutível independente do modelo preditivo utilizado - Ao final chegaremos aos famosos gráficos de decomposição do bias-variance apresentados nos livros, mas que comumente não possuem explicação quanto sua construção.



```r
library(tidyverse)


set.seed(42)

fun <- function(x) x^2

ref <- tibble(x = seq(0,1,0.1)) %>% 
  mutate(y = fun(x))

data_sim <- function(n = 50){
  
  x = runif(n = n, min = 0, max = 1)
  y = fun(x) + rnorm(n = n, mean = 0, sd = 0.2)
  
  data = tibble::tibble(x, y)
  return(data)
}

dados = data.frame(modelo = NA, x = NA, y = NA, pred = NA)

for (i in 1:500) {
  
  sim <- data_sim()
  
model0 <- lm(y ~ 1, data = sim) %>% 
  predict(select(ref, x))

model1 <- lm(y ~ poly(x, degree = 1), data = sim) %>%
  predict(select(ref, x))

model2 <- lm(y ~ poly(x, degree = 2), data = sim) %>%
  predict(select(ref, x))

model3 <- lm(y ~ poly(x, degree = 3), data = sim) %>%
  predict(select(ref, x))

model4 <- lm(y ~ poly(x, degree = 4), data = sim) %>%
  predict(select(ref, x))

model5 <- lm(y ~ poly(x, degree = 5), data = sim) %>%
  predict(select(ref, x))

model6 <- lm(y ~ poly(x, degree = 6), data = sim) %>%
  predict(select(ref, x))

model7 <- lm(y ~ poly(x, degree = 7), data = sim) %>%
  predict(select(ref, x))

model8 <- lm(y ~ poly(x, degree = 8), data = sim) %>%
  predict(select(ref, x))

eps <- rnorm(n = 11, mean = 0, sd = 0.2)

library(magrittr)

dados %<>% 
  rbind(data.frame(modelo = 0, x = select(ref, x), 
                   select(ref, y)+eps, pred = model0))  %>% 
  rbind(data.frame(modelo = 1, x = select(ref, x),
                   select(ref, y)+eps, pred = model1)) %>% 
  rbind(data.frame(modelo = 2, x = select(ref, x),
                   select(ref, y)+eps, pred = model2)) %>% 
  rbind(data.frame(modelo = 3, x = select(ref, x),
                   select(ref, y)+eps, pred = model3)) %>% 
  rbind(data.frame(modelo = 4, x = select(ref, x),
                   select(ref, y)+eps, pred = model4)) %>% 
  rbind(data.frame(modelo = 5, x = select(ref, x),
                   select(ref, y)+eps, pred = model5)) %>% 
  rbind(data.frame(modelo = 6, x = select(ref, x),
                   select(ref, y)+eps, pred = model6)) %>% 
  rbind(data.frame(modelo = 7, x = select(ref, x),
                   select(ref, y)+eps, pred = model7)) %>% 
  rbind(data.frame(modelo = 8, x = select(ref, x),
                   select(ref, y)+eps, pred = model8))
}

dados %<>% as.tibble() %>% na.omit()

var <- dados %>% 
  group_by(modelo, x) %>% 
  summarise(varfx = var(pred)) %>% 
  group_by(modelo) %>% 
  summarise(varf = mean(varfx))

bias <- dados %>% 
  group_by(modelo, x) %>% 
  summarise(meanf = mean(pred)) %>% 
  mutate(bias2 = (meanf - fun(x))^2) %>% 
  group_by(modelo) %>% 
  summarise(bias2f = mean(bias2))

mse <- dados %>% 
  group_by(modelo, x) %>% 
  mutate(error = (pred - y)^2) %>%
  group_by(modelo) %>% 
  summarise(meanmse = mean(error))

resume <- bias %>% 
  bind_cols(var %>% select(varf)) %>% 
  bind_cols(mse %>% select(meanmse)) %>% 
  mutate(eps = meanmse - bias2f - varf) %>% 
  select(modelo, bias2f, varf, eps, meanmse)

resume

resume %>% 
  reshape2::melt(id.var = "modelo") %>% 
  ggplot(aes(x = modelo, y = value, col = variable)) +
  geom_line() + geom_point()
```

