
#' Apagar todos objetos criados
rm(list=ls()) 


# Carregar Pacotes --------------------------------------------------------
require(tidyverse)
require(skimr)
require(ggplot2)

# Carregar base de dados --------------------------------------------------


load("dados/humidity_temperature_manaus.rda") # carregar base de dados no formato rda
dados_brutos = base_manaus
glimpse(dados_brutos) # mesmo que str(dados)
head(dados_brutos)
unique(dados_brutos$year) |> length()

# Manipulação -------------------------------------------------------------
month_name = rep(month.abb,12) |> factor(levels = month.abb)


dados  = dados_brutos |>
  dplyr::rename(month_number = month) |>
  dplyr::mutate( month = month_name) |>
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


## Parte 1 -----------------------------------------------------------------


dados$rh |> summary()
apply(dados[,c(5,6,7)],2, summary)
apply(dados[,c(5,6,7)],2, skimr::skim)

descritivas = dados_pivot |> 
  group_by(variavel) |>
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

#' Correlação linear

cor(dados[,c("rh","dbt","wbt")])


## Parte 2: gráficos básicos -----------------------------------------------------------------

#' Gráfico de linhas

plot(dados$rh,type="l",ylab="Umidade Relativa",xlab="t")
plot.ts(dados$rh)
plot.ts(dados[,c("rh","dbt","wbt")])


#' Histograma
hist(dados$rh,main="Histograma",ylab = "Frequência",xlab="Umidade Relativa")
abline(v=c(mean(dados$rh),median(dados$rh) ),col=c(1,2))

#' Fazer histograma para dbt e wbt

#' Colocar vários gráficos em uma mesma janela

par(mfrow=c(1,2)) # matriz de 1 linha e duas colunas
hist(dados$rh,main="Histograma",ylab = "Frequência",xlab="Umidade Relativa")
hist(dados$dbt,main="Histograma",ylab = "Frequência",xlab="Temperatura")
abline(v=c(mean(dados$dbt),median(dados$dbt) ),col=c(1,2))

#' scatterplot
plot(dados[,c("rh","dbt","wbt")]) # plot(dados[,c(1,2,3)])

#' boxplot
boxplot(dados$rh~dados$month)

#'  gráficos ggplot2

ggplot(dados, mapping = aes(x = ano_mes, y = rh)) +  # camada de dados
  geom_line() +                                      # camada geométrica: linha
  geom_point(pch = 1) +                              # camada geométrica: pontos com contorno
  ylab("Umidade") +                                  # rótulo do eixo Y
  xlab("Data") +                                     # rótulo do eixo X
  theme_dark()                                         # tema preto e branco (limpo)

ggplot(dados, mapping = aes(x = month, y = rh)) +  # camada de dados
  geom_boxplot() +                                      # camada geométrica: linha
  geom_point(pch = 1) +                              # camada geométrica: pontos com contorno
  ylab("Umidade") +                                  # rótulo do eixo Y
  xlab("Data") +                                     # rótulo do eixo X
  theme_bw()   

dados_pivot |>
  ggplot(mapping = aes(x=month,y=valores)) +
  geom_boxplot() +                                      # camada geométrica: linha
  geom_point(pch = 1)+
  facet_wrap(~variavel,scales="free_y",ncol=1)


dados_pivot |>
  ggplot(mapping = aes(x=month,y=valores)) +
  geom_boxplot() +                                      # camada geométrica: linha
  geom_point(pch = 1)+
  facet_wrap(~variavel,scales="free_y",ncol=1)



