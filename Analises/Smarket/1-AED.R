rm(list=ls())
library(ISLR)
library(caret)

data(Smarket)
dados = Smarket
# Verificando estrutura
str(Smarket)

cor(dados[,-c(1,9)])

plot(dados[,-c(1,9)])

plot(dados$Today,dados$Volume)

boxplot(Volume ~ Direction, data = Smarket, main = "Volume x Direção do Mercado")
