
#' Apagar todos objetos criados
rm(list=ls()) 


# Carregar Pacotes --------------------------------------------------------
require(tidyverse)
require(caret)

# Carregar base de dados --------------------------------------------------


load("dados/humidity_temperature_manaus.rda") # carregar base de dados no formato rda
dados_brutos = base_manaus
glimpse(dados_brutos) # mesmo que str(dados)
head(dados_brutos)
unique(dados_brutos$year) |> length()

dados_brutos
dados = dados_brutos |> mutate(tempo = 1:144,seno = sin(2*pi*tempo/12),
                               cosseno = cos(2*pi*tempo/12))
particao <- 1:132
treino <- dados[particao, ]
teste  <- dados[-particao, ]



controle_ts <- trainControl(
  method = "timeslice",
  initialWindow = 5*12,  # usa os 60 primeiros meses como treino inicial
  horizon = 12,          # prevê 12 meses à frente
  fixedWindow = TRUE,
  savePredictions = "final",
  verboseIter = TRUE
)


# lm method ----------------------------------------------------------------

lm.model.1 = train(
  dbt ~ tempo,
  data = treino,
  method = "lm",
  trControl = controle_ts
)
plot.ts(treino$dbt)
lines(predict(lm.model.1),col=2)

lm.model.2 = train(
  dbt ~ rh+tempo,
  data = treino,
  method = "lm",
  trControl = controle_ts
)
plot.ts(treino$dbt)
lines(predict(lm.model.2),col=2)

plot.ts(teste$dbt)
pred_test = predict(lm.model.2,newdata = teste)
lines(pred_test,col=2)
postResample(pred_test,teste$dbt)


