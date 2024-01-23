require(tidyverse)
# Questão 1 ---------------------------------------------------------------

## a) --------
# Qual problema temos na base de dados dados_am_dengue?
dados_am = readRDS("~/GitHub/Introducao_Ciencias_de_Dados/dados/dados_am.rds")
ano = paste0("n_dengue_",as.character(2020:2022))
n_dengue = tibble(
  rpois(62,1500),
  rpois(62,3000),
  rpois(62,2000),
  .name_repair = ~ano 
  
)
dados_am_dengue = cbind(dados_am,n_dengue)

##b)----
# coloque a base de dados dados_am_dengue no formato tidy data.
# Faça um box plot para saber o comportamento de registro de dengue durante
# os anos
dados_longer = dados_am_dengue %>%
  tidyr::pivot_longer(
    col = dplyr::starts_with("n_"),
    names_to = "Ano",
    values_to = "n_registro"
  ) %>%
  relocate(NOME,Ano,n_registro) 

# Vamos deixar somente o ano de "n_dengue_ano" 
dados_longer = dados_am_dengue %>%
  tidyr::pivot_longer(
    col = dplyr::starts_with("n_"),
    names_to = "Ano",
    values_to = "n_registro"
  ) %>%
  relocate(NOME, Ano, n_registro) %>%
  mutate(Ano = stringr::str_extract(Ano, "[0-9]+"))

dados_longer %>% ggplot()+
  geom_boxplot(aes(x=Ano,y=n_registro)) +
  theme_bw()

##c)-----
# calcule o total e média de casos considerando:

#Ano
dados_longer %>% 
  group_by(Ano) %>% 
  summarise(
    media = mean(n_registro),
    total = sum(n_registro)
  )
#MESOREGIAO e ano
dados_longer %>% 
  group_by(MESOREGIAO,Ano) %>% 
  summarise(
    media = mean(n_registro),
    total = sum(n_registro)
  )
#MICROREGIA e ano
dados_longer %>% 
  group_by(MICROREGIA,Ano) %>% 
  summarise(
    media = mean(n_registro),
    total = sum(n_registro)
  )

# Questão 2 ---------------------------------------------------------------

# Pesquise sobre as funções tidyr::separate() e tidyr::unite() e 
# Elabore uma base de dados no formato tibble e aplique as funções



# Questão 3 ---------------------------------------------------------------

expectativa_vida_brasil_2017 <- readRDS("dados/expectativa_vida_brasil_2017.rds") %>% as_tibble()

##a)------ 
# Calcule as estatistica descritivas da ESPVIDA2017 considerando a região

##b)--------
# com a função mutate simule a variável ESPVIDA2018 : 
# ESPVIDA2018 = rnorm(
# length(ESPVIDA2017),
# 1.5*mean(ESPVIDA2017,na.rm = T),
# sd(ESPVIDA2017,na.rm = T)

##c) Coloque no formato tidy data

##d) --------
# Calcule as estatistica descritivas


# Questão 4 ---------------------------------------------------------------

# Considere os dados questionario.xlsx
# os números são as possíveis respostas para cada pergunta
# Os números representam textos e possuem significados diferentes em cada pergunta
require(readxl)
dados = readxl::read_xlsx("dados/questionario.xlsx",col_types = "text")


# Quantas pessoas (abs e porcentagem) responderam "2" na pergunta_1?
# Quantas pessoas (abs e porcentagem) responderam "3" na pergunta_2?

# Construa uma tabela que dê a frequência (abs e porcentagem) das respostas dentro de cada pergunta
