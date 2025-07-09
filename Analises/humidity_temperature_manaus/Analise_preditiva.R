
#' Apagar todos objetos criados
rm(list=ls()) 


# Carregar Pacotes --------------------------------------------------------


# Carregar base de dados --------------------------------------------------


load("dados/humidity_temperature_manaus.rda") # carregar base de dados no formato rda
dados_brutos = base_manaus
glimpse(dados_brutos) # mesmo que str(dados)
head(dados_brutos)
unique(dados_brutos$year) |> length()

dados_brutos

controle_ts <- trainControl(
  method = "timeslice",
  initialWindow = 5*12,  # usa os 60 primeiros meses como treino inicial
  horizon = 12,          # prevê 12 meses à frente
  fixedWindow = TRUE,
  savePredictions = "final",
  verboseIter = TRUE
)

