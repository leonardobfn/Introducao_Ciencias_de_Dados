# Instalações dos pacotes --------------------------------------------------
#install.packages("readxl")
#install.packages(c("caret", "mgcv", "gam"))

# Carregar pacotes --------------------------------------------------------
require(ggplot2)
require(gam)
require(mgcv)
require(caret)
require(tidyverse)
dados_brutos = readxl::read_xlsx(
  "dados/Dados_Livro_Estatistica_e_CD/covid2.xlsx",
  sheet = "dados",
  col_types = c("date", "numeric", "numeric")
)

plot.ts(dados_brutos$obitos)

dados = dados_brutos |>
  dplyr::mutate(
    tt = 1:nrow(dados_brutos),
    ano = lubridate::year(dia),
    mes = lubridate::month(dia, label = T),
    dia_semana = lubridate::wday(dia, label = T) ,
    semana = lubridate::week(dia),
    letalidade = (obitos/casos)*100) |>
  dplyr::relocate(dia, ano, mes, dia_semana, obitos, casos) |>
  data.frame()


controle_ts <- trainControl(
  method = "timeslice",
  initialWindow = 30*15, 
  horizon = 12,          # prevê 12 meses à frente
  fixedWindow = TRUE,
  savePredictions = "final",
  verboseIter = TRUE
)

modelo_gam <- train(
  obitos ~ tt+dia_semana,
  data = dados,
  method = "gamSpline",
  trControl = controle_ts,
  tuneGrid = expand.grid(df = c(2, 4, 6, 8, 10, 15,20,70))
)
postResample(predict(modelo_gam),dados$obitos)
print(modelo_gam)
#plot(modelo_gam)
plot.ts(dados_brutos$obitos)
predict(modelo_gam) |> lines(col=2)

#utilizando a função gam
modelo_gam_2 <- gam(obitos ~ s(tt,8)+dia_semana , data = dados[c(1:(30*15)),])
pred2 = predict(modelo_gam_2,newdata = dados[-c(1:(30*15)),]) 
plot.ts(dados$obitos[-c(1:(30*15))])

lines(pred2,col=2)




