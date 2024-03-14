#' aplicar deep learning para classificar se o indivíduo tem ou
#' não diabetes. Base de dados PimaIndiansDiabetes2 (mlbench) 
#' Compare com a função glm

require(tidyverse)
require(keras)
install.packages('mlbench')
require(mlbench)
rm(list=ls())

data(PimaIndiansDiabetes2)
dados.brutos = PimaIndiansDiabetes2
head(dados.brutos)

dados = na.omit(dados.brutos)
head(dados)

table(dados$diabetes) 









