
#' Apagar todos objetos criados
rm(list=ls()) 


# Carregar Pacotes --------------------------------------------------------
require(tidyverse)
require(caret)
library(glmnet)
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


# regularizacao method ----------------------------------------------------------------

lm.model.1 = train(
  dbt ~ tempo + seno + cosseno + rh + wbt,
  data = treino,
  method = "glmnet",
  trControl = controle_ts,
  tuneGrid = expand.grid(
    alpha = 0,
    # Ridge: alpha = 0
    lambda = seq(0.001, 50, length = 50)
  )
)

lm.model.1$bestTune
coef(lm.model.1$finalModel, s = lm.model.1$bestTune$lambda)

plot.ts(treino$dbt)
lines(predict(lm.model.1,s = lm.model.1$bestTune$lambda),col=2)

plot.ts(teste$dbt)
pred_test = predict(lm.model.1,newdata = teste,s= lm.model.1$bestTune$lambda)
lines(pred_test,col=2)
postResample(pred_test,teste$dbt)


lm.model.2 = train(
  dbt ~ tempo + seno + cosseno + rh + wbt,
  data = treino,
  method = "glmnet",
  trControl = controle_ts,
  tuneGrid = expand.grid(
    alpha = 1,
    # lasso: alpha = 1
    lambda = seq(0.001, 50, length = 50)
  )
)

lm.model.2$bestTune
coef(lm.model.2$finalModel, s = lm.model.2$bestTune$lambda)

plot.ts(treino$dbt)
lines(predict(lm.model.2,s=lm.model.2$bestTune$lambda),col=2)

plot.ts(teste$dbt)
pred_test = predict(lm.model.2,newdata = teste,s=lm.model.2$bestTune$lambda)
lines(pred_test,col=2)
postResample(pred_test,teste$dbt)


lm.model.3 <- train(
  dbt ~ tempo + seno + cosseno + rh + wbt,
  treino,
  method = "glmnet",
  trControl = controle_ts,
  tuneLength = 10  # Varia alpha e lambda automaticamente
)

lm.model.3$bestTune
coef(lm.model.3$finalModel, s = lm.model.3$bestTune$lambda)

plot.ts(treino$dbt)
lines(predict(lm.model.3,s=lm.model.3$bestTune$lambda),col=2)

plot.ts(teste$dbt)
pred_test = predict(lm.model.3,newdata = teste,s=lm.model.3$bestTune$lambda)
lines(pred_test,col=2)
postResample(pred_test,teste$dbt)



