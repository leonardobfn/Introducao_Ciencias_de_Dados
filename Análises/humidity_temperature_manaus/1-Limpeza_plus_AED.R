
#' Apagar todos objetos criados
rm(list=ls()) 


# Carregar Pacotes --------------------------------------------------------
require(tidyverse)
require(skimr)

# Carregar base de dados --------------------------------------------------


load("dados/humidity_temperature_manaus.rda") # carregar base de dados no formato rda
dados_brutos = base_manaus
glimpse(dados_brutos) # mesmo que str(dados)
head(dados_brutos)
unique(dados_brutos$year) |> length()

# Manipulação -------------------------------------------------------------
month = rep(month.abb,12) |> factor(levels = month.abb)


dados  = dados_brutos |>
  dplyr::rename(month_number = month) |>
  dplyr::mutate( month = month) |>
  dplyr::relocate(year,month,month_number, dplyr::everything()) |>
  tidyr::unite("ano_mes",year,month_number,sep="/",remove = F) |>
  dplyr::mutate(ano_mes = zoo::as.yearmon(ano_mes, format = "%Y / %m"))

dados_pivot = dados |> 
  tidyr::pivot_longer(
  cols = c("rh", "dbt", "wbt"),
  names_to = "variavel",
  values_to = "valores"
)

# Descritivas -------------------------------------------------------------

dados$rh |> summary()
apply(dados[,c(5,6,7)],2, summary)
apply(dados[,c(5,6,7)],2, skimr::skim)

descritivas = dados_pivot |> group_by(variavel) |>
  summarise(
    n = n(),
    media = mean(valores, na.rm = TRUE),
    mediana = median(valores, na.rm = TRUE),
    desvio_padrao = sd(valores, na.rm = TRUE),
    coef_variacao = desvio_padrao/media,
    minimo = min(valores, na.rm = TRUE),
    maximo = max(valores, na.rm = TRUE),
    q25 = quantile(valores, 0.25, na.rm = TRUE),
    q75 = quantile(valores, 0.75, na.rm = TRUE)
  )

descritivas |> pivot_longer(where(is.double),names_to = "Estatísticas",values_to = "Valores")


