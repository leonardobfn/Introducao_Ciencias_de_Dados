
#' Apagar todos objetos criados
rm(list=ls()) 


# Carregar Pacotes --------------------------------------------------------
require(tidyverse)
require(caret)
library(mgcv)
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
  initialWindow = 2*12,  # usa os 60 primeiros meses como treino inicial
  horizon = 12,          # prevê 12 meses à frente
  fixedWindow = TRUE,
  savePredictions = "final",
  verboseIter = TRUE
)


# gam method ----------------------------------------------------------------

gam.model.1 = train(
  dbt ~ tempo ,
  data = treino,
  method = "gamSpline",
  trControl = controle_ts,
  tuneGrid = data.frame(df = c(2,3,5,6,8,12,14,20))
  )


gam.model.1$bestTune
coef(gam.model.1$finalModel, s = gam.model.1$bestTune)

plot.ts(treino$dbt)
lines(predict(gam.model.1,s = gam.model.1$bestTune),col=2)

plot.ts(teste$dbt)
pred_test = predict(gam.model.1,newdata = teste,s = gam.model.1$bestTune)
lines(pred_test,col=2)
postResample(pred_test,teste$dbt)


plot(gam.model.1$finalModel,se = T)


gam.model.2 = train(
  dbt ~ tempo + rh +  wbt,
  data = treino,
  method = "gamSpline",
  trControl = controle_ts,
  tuneGrid = data.frame(df = c(2,3,5,6,8,12,14,20))
)

gam.model.2$bestTune
coef(gam.model.2$finalModel, s = gam.model.2$bestTune)

plot.ts(treino$dbt)
lines(predict(gam.model.2,s = gam.model.2$bestTune),col=2)

plot.ts(teste$dbt)
pred_test = predict(gam.model.2,newdata = teste,s = gam.model.2$bestTune)
lines(pred_test,col=2)
postResample(pred_test,teste$dbt)

plot(gam.model.2$finalModel,se=T)
