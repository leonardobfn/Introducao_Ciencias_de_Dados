
rm(list = ls())

# Instalações dos pacotes --------------------------------------------------
#install.packages("readxl")


# Carregar pacotes --------------------------------------------------------
require(tidyverse)
require(caret)
require(mgcv)
dados_brutos = readxl::read_xlsx(
  "dados/Dados_Livro_Estatistica_e_CD/covid2.xlsx",
  sheet = "dados",
  col_types = c("date", "numeric", "numeric")
)

plot.ts(dados_brutos$obitos)

dados = dados_brutos |>
  dplyr::mutate(
    ano = lubridate::year(dia),
    mes = lubridate::month(dia, label = T),
    dia_semana = lubridate::wday(dia, label = T),
    semana = lubridate::week(dia),
    letalidade = (obitos/casos)*100) |>
  dplyr::relocate(dia, ano, mes, dia_semana, obitos, casos)


dados_brutos
dados = dados |> mutate(tempo = 1:nrow(dados),
                        dia_semana = as.numeric(dia_semana) |> as.factor())
particao <- 1:(30*15)
treino <- dados[particao, ]
teste  <- dados[-particao, ]



controle_ts <- trainControl(
  method = "timeslice",
  initialWindow = 6*30,  
  horizon = 12,          
  fixedWindow = TRUE,
  savePredictions = "final",
  verboseIter = TRUE
)

# lm method ----------------------------------------------------------------


lm.model.1 = caret::train(
  obitos ~ tempo ,
  data = treino,
  method = "lm",
  trControl = controle_ts,
)


coef(lm.model.1$finalModel)

plot.ts(treino$obitos)
lines(predict(lm.model.1) |> floor(),col=2)

plot.ts(teste$obitos)
pred_test = predict(lm.model.1,newdata = teste)
lines(pred_test,col=2)
postResample(pred_test,teste$obitos)


# gam method ----------------------------------------------------------------

gam.model.1 = caret::train(
  obitos ~ tempo ,
  data = treino,
  method = "gamSpline",
  trControl = controle_ts,
  tuneGrid = data.frame(df = c(2,3,5,6,8,12,14,20))
)


gam.model.1$bestTune
coef(gam.model.1$finalModel, s = gam.model.1$bestTune)

plot.ts(treino$obitos)
pred_treino = predict(gam.model.1,s = gam.model.1$bestTune)|> floor()
lines(pred_treino,col=2)


plot.ts(teste$obitos)
pred_test = predict(gam.model.1,,newdata = teste,s = gam.model.1$bestTune)
lines(pred_test,col=2)
postResample(pred_test,teste$obitos)

plot.ts(dados$obitos)
lines(c(pred_treino,pred_test),col=c(2,3))
abline(v = particao[length(particao)])
plot(gam.model.1$finalModel,se = T)


gam.model.2 = caret::train(
  obitos ~ tempo+dia_semana ,
  data = treino,
  method = "gamSpline",
  trControl = controle_ts,
  tuneGrid = data.frame(df = c(2,3,5,6,8,12,14,20))
)

gam.model.2$bestTune
coef(gam.model.2$finalModel, s = gam.model.2$bestTune)

plot.ts(treino$obitos)
pred_treino = predict(gam.model.2,s = gam.model.2$bestTune) |> floor()
lines(pred_treino,col=2)


plot.ts(teste$obitos)
pred_test = predict(gam.model.2,,newdata = teste,s = gam.model.2$bestTune)
lines(pred_test,col=2)
postResample(pred_test,teste$obitos)


plot.ts(dados$obitos)
lines(c(pred_treino,pred_test),col=c(2,3))
abline(v = particao[length(particao)])

plot(gam.model.2$finalModel,se = T)
